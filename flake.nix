{
  description = "RedNix - offensive security toolkit";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    pwndbg = {
      url = "github:pwndbg/pwndbg";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # microvm.nix runs the toolkit as a lightweight NixOS VM. The qemu
    # backend works on Linux hosts (KVM) and macOS hosts (HVF) alike.
    microvm = {
      url = "github:microvm-nix/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nix-alien: runtime patcher for foreign ELFs whose libs nixpkgs
    # doesn't expose under FHS paths.
    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      ...
    }:
    let
      useUnfreeAllowlist = true;
      useInsecureAllowlist = true;
      usePwndbg = true;
      useNrfutil = true;
      useNixAlien = true;
      sourceToggles = {
        inherit
          usePwndbg
          useNrfutil
          useNixAlien
          ;
      };

      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      linuxSystems = builtins.filter (s: nixpkgs.lib.hasSuffix "-linux" s) supportedSystems;
      genSystems = nixpkgs.lib.genAttrs supportedSystems;
      genLinuxSystems = nixpkgs.lib.genAttrs linuxSystems;
      pkgs = genSystems (
        system:
        import nixpkgs {
          inherit system;
          config = import ./nixpkgs-config.nix {
            inherit useUnfreeAllowlist useInsecureAllowlist;
          };
        }
      );
      rednixLib = import ./lib.nix { inherit (nixpkgs) lib; };
      skipFor =
        system: if pkgs.${system}.stdenv.hostPlatform.isDarwin then import ./darwin-skip.nix else [ ];
      # One Linux guest config, one runner per host system. On darwin hosts
      # the guest stays Linux (aarch64-darwin gives aarch64-linux) and
      # microvm.vmHostPackages makes the qemu runner itself darwin-native
      # (HVF acceleration).
      mkMicrovm =
        hostSystem: extraModules:
        let
          guestSystem = builtins.replaceStrings [ "-darwin" ] [ "-linux" ] hostSystem;
        in
        nixpkgs.lib.nixosSystem {
          system = guestSystem;
          specialArgs = {
            rednixPackages = nixpkgs.lib.flatten (builtins.attrValues self.packagesByCategory.${guestSystem});
          };
          modules = [
            inputs.microvm.nixosModules.microvm
            ./microvm.nix
          ]
          ++ nixpkgs.lib.optional (hostSystem != guestSystem) {
            microvm.vmHostPackages = pkgs.${hostSystem};
          }
          ++ extraModules;
        };
    in
    {
      formatter = genSystems (
        system:
        let
          p = pkgs.${system};
        in
        p.writeShellApplication {
          name = "nixfmt-tree";
          runtimeInputs = [
            p.nixfmt
            p.findutils
          ];
          text = ''
            if [ "$#" -eq 0 ]; then set -- .; fi
            for arg in "$@"; do
              if [ -d "$arg" ]; then
                find "$arg" -name '*.nix' -not -path '*/.drafts/*' -exec nixfmt {} +
              else
                nixfmt "$arg"
              fi
            done
          '';
        }
      );

      devShells = genSystems (
        system:
        import ./shells {
          pkgs = pkgs.${system};
          packagesByCategory = self.packagesByCategory.${system};
        }
      );

      # Per-system, per-category package list, post-filter.
      packagesByCategory = genSystems (
        system:
        let
          inherit (nixpkgs.lib) filter mapAttrs;
          isAvailable = rednixLib.mkIsAvailable {
            hostPlatform = pkgs.${system}.stdenv.hostPlatform;
            skip = skipFor system;
          };
        in
        mapAttrs (_: filter isAvailable) (
          import ./packages.nix (
            {
              pkgs = pkgs.${system};
              inherit inputs;
            }
            // sourceToggles
          )
        )
      );

      packages = genSystems (
        system:
        let
          inherit (nixpkgs.lib) flatten warn;
          packagesList = flatten (builtins.attrValues self.packagesByCategory.${system});
          # Fold to a pname-keyed attrset, warning on collisions instead of
          # silently first-winning like bare listToAttrs.
          named = builtins.foldl' (
            acc: p:
            let
              key = p.pname or p.name;
              prior = acc.${key} or null;
            in
            if prior == null || prior.drvPath == p.drvPath then
              acc // { ${key} = p; }
            else
              warn "rednix: pname collision on \"${key}\" in the flat packages output — keeping ${prior.drvPath}, dropping ${p.drvPath}; disambiguate in packages.nix" acc
          ) { } packagesList;
        in
        named
        // {
          # `nix build .#` aggregate: forces every available package to build,
          # so it doubles as a smoke test for the whole package list.
          default = pkgs.${system}.buildEnv {
            name = "rednix-toolkit";
            paths = packagesList;
            ignoreCollisions = true;
          };
          # `nix run .#microvm` boots the toolkit VM on this host. Linux
          # hosts reuse the nixosConfigurations entry; darwin hosts get an
          # inline variant with a darwin-native qemu runner.
          microvm =
            if pkgs.${system}.stdenv.hostPlatform.isLinux then
              self.nixosConfigurations.${system}.config.microvm.declaredRunner
            else
              (mkMicrovm system [ ]).config.microvm.declaredRunner;
        }
      );

      # Eval-time tripwire for the mkIsAvailable tryEval clause, which
      # otherwise swallows unfree-allowlist misses and upstream eval
      # breakage silently.
      checks.x86_64-linux.no-silent-drops =
        let
          inherit (nixpkgs.lib)
            flatten
            filterAttrs
            groupBy
            concatStringsSep
            ;
          entriesFor =
            system:
            let
              dropReason = rednixLib.mkDropReason {
                hostPlatform = pkgs.${system}.stdenv.hostPlatform;
                skip = skipFor system;
              };
              nameOf =
                p:
                let
                  t = builtins.tryEval (p.pname or p.name or "");
                in
                if t.success then t.value else "<unnamed>";
            in
            map
              (p: {
                name = nameOf p;
                reason = dropReason p;
              })
              (
                flatten (
                  builtins.attrValues (
                    import ./packages.nix (
                      {
                        pkgs = pkgs.${system};
                        inherit inputs;
                      }
                      // sourceToggles
                    )
                  )
                )
              );
          # pname-keyed grouping: two distinct entries sharing a pname would
          # merge into one bucket
          byName = groupBy (e: e.name) (flatten (map entriesFor supportedSystems));
          silent = builtins.attrNames (
            filterAttrs (
              _: es: builtins.all (e: e.reason != null) es && builtins.any (e: e.reason == "eval") es
            ) byName
          );
        in
        if silent == [ ] then
          pkgs.x86_64-linux.runCommand "no-silent-drops" { } "touch $out"
        else
          throw ''
            rednix: dropped from every system they're declared for, at least
            partly by the silent tryEval clause (unfree allowlist miss or
            upstream eval breakage?): ${concatStringsSep ", " silent}
          '';

      nixosConfigurations = genLinuxSystems (hostSystem: mkMicrovm hostSystem [ ]);

      # The RedNix guest as a reusable NixOS module, for downstreams that want
      # to embed the microVM in their own microvm host config. Contract: the
      # importing nixosSystem must (1) also import
      # inputs.microvm.nixosModules.microvm, and (2) supply `rednixPackages`,
      # a flat list of derivations, e.g.
      # `lib.flatten (builtins.attrValues rednix.packagesByCategory.<system>)`,
      # via specialArgs. See mkMicrovm above for the reference wiring.
      # `import` (not a bare path) so the flake `nixosModules` schema check
      # sees the module function directly.
      nixosModules.rednix = import ./microvm.nix;
    };
}
