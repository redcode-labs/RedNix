# Allowlist of package pnames permitted under nixpkgs' allowUnfree gate.
# Mirrors insecure-packages.nix: add an entry (the package's pname or name
# attribute) when `nix build` refuses to evaluate an unfree package from
# packages.nix. The predicate also runs on transitive deps, so an unfree
# dep dragged in by a free package needs an entry here too.
[
  "adreaper"
  "agneyastra"
  "brakeman"
  "burpsuite"
  "cf-hero"
  "crack-hash"
  "firefox-bin"
  "firefox-bin-unwrapped" # transitive: firefox-bin wraps it
  "graphqlmaker"
  "msodbcsql18"
  "ngrok"
  "nrfutil"
  "padre"
  "ruler"
  "secrets-extractor"
  "nrfutil-completion" # transitive: shipped with nrfutil
  "segger-jlink" # transitive: nrfutil dep on linux
  "unrar"
  "volatility3"
  "wprecon"
  "wpscan"
]
