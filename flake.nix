{
  description = "RedNix Hackable NixOS Container";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    hackpkgs = {
      url = "github:applePrincess/hackpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "utils";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    utils,
    hackpkgs,
  }: let
    supportedSystems = ["aarch64-linux" "aarch64-darwin" "x86_64-darwin" "x86_64-linux"];
    genSystems = nixpkgs.lib.genAttrs supportedSystems;
    pkgs = genSystems (system:
      import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowBroken = true;
          allowInsecurePredicate = p: true;
        };
      });
  in {
    # auto-generated devShells
    devShells = genSystems (system:
      import ./shells {
        pkgs = pkgs.${system};
        inherit inputs;
      });

    packages = genSystems (system: let
      inherit (nixpkgs.lib) attrValues flatten listToAttrs nameValuePair;
      packages = flatten (attrValues (import ./packages.nix {
        pkgs = pkgs.${system};
        inherit inputs;
      }));
    in
      listToAttrs (map (n: nameValuePair (n.pname or n.name) n) packages));

    # use with nixos-container
    nixosConfigurations = genSystems (system:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [./container.nix];
      });

    # import into your config for declarative containers
    container = ./container.nix;
  };
}
