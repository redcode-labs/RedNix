pkgs: let
  packages = import ../packages.nix pkgs;
  shells = builtins.mapAttrs (n: v:
    pkgs.mkShell {
      packages = v;
      name = n;
    })
  packages;
in
  shells
  // {
    default = pkgs.mkShell {
      packages = pkgs.lib.flatten (builtins.attrValues packages);
      name = "default";
    };
  }
