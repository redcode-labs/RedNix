# Shared helpers for the flake. Anything imported by both flake.nix and
# shells/default.nix lives here.
{ lib }:
let
  # Classifies why mkIsAvailable would drop a package; null = it survives.
  mkDropReason =
    {
      hostPlatform,
      skip ? [ ],
    }:
    p:
    if !(lib.meta.availableOn hostPlatform p) then
      "platform"
    else if p.meta.broken or false then
      "broken"
    else if !(builtins.tryEval p.drvPath).success then
      "eval"
    else if builtins.elem (p.pname or p.name or "") skip then
      "skip"
    else
      null;
in
{
  # Predicate used to filter the package list before handing it to mkShell or
  # buildEnv. Matches a package iff:
  #   1. nixpkgs reports it as available on the host platform
  #      (meta.platforms / meta.badPlatforms),
  #   2. it isn't marked broken,
  #   3. its drvPath actually evaluates, catching packages whose deps fail
  #      platform asserts (e.g. a darwin-tagged tool depending on Linux-only
  #      bluez), which slips through the meta.availableOn check, and
  #   4. its pname (or name as fallback) isn't in the per-system skip list,
  #      which is how we exclude packages with confirmed darwin build
  #      failures; see darwin-skip.nix.
  # The authoritative four-clause chain lives in mkDropReason; this predicate
  # derives from it so both can never drift apart.
  mkIsAvailable = args: p: (mkDropReason args p) == null;

  inherit mkDropReason;
}
