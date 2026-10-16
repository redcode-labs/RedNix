#   useUnfreeAllowlist   = false  →  allow every unfree pkg (no gate)
#   useInsecureAllowlist = false  →  allow every insecure pkg (no gate)
{
  useUnfreeAllowlist ? true,
  useInsecureAllowlist ? true,
}:
{
  allowUnfreePredicate =
    if useUnfreeAllowlist then
      (p: builtins.elem (p.pname or p.name) (import ./unfree-packages.nix))
    else
      (_: true);
  allowInsecurePredicate =
    if useInsecureAllowlist then
      (p: builtins.elem (p.pname or p.name) (import ./insecure-packages.nix))
    else
      (_: true);
  segger-jlink.acceptLicense = true;
}
