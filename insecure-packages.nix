# Allowlist of package pnames permitted despite known vulnerabilities.
# Add an entry (the package's pname or name attribute) when `nix build`
# refuses to evaluate an insecure package from packages.nix.
[
  # Transitive dep of checkov. ecdsa 0.19.x carries CVE-2024-23342
  "ecdsa"

  # tunnelgraf pins paramiko 3.4.0 (upstream: newer paramiko breaks it),
  # which nixpkgs flags with CVE-2026-44405
  "paramiko"
]
