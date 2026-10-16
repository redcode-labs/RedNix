# Per-category dev shells. The package lists arrive already filtered via
# `packagesByCategory` (flake.nix), the same source of truth as the
# `packages` output.
{
  pkgs,
  packagesByCategory,
}:
let
  inherit (pkgs) lib;
  # One mkShell per category, with a shellHook announcing the category and
  # how many tools it brought in.
  mkCatShell =
    name: drvs:
    pkgs.mkShell {
      inherit name;
      packages = drvs;
      shellHook = ''echo "rednix · ${name} · ${toString (builtins.length drvs)} tools"'';
    };
  shells = builtins.mapAttrs mkCatShell packagesByCategory;
in
shells
// {
  default = mkCatShell "default" (lib.flatten (builtins.attrValues packagesByCategory));
}
