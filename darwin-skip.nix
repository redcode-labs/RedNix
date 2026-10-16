# `pname`s of packages whose darwin build is broken upstream (case-insensitive
# APFS collisions, glibc-only headers, removed libc++ APIs, dnspython tests
# failing in CI, etc.). Filtered out by pname so it works for both top-level
# and nested attrs (e.g. `python310Packages.safety` has pname="safety").
# Append a name when a new build failure surfaces; drop one when retrying
# confirms it builds again or nixpkgs marks it broken upstream.
[
  "wipe"
  "dcfldd"
  "siege"
  "cardpeek"
  "libfreefare"
  "junkie"
  "ncrack"
  "netdiscover"
  "corkscrew"
  "ntp"
  "sage"
  "sage-with-env"
  "ronin"
  "driftnet"
  "chrony"
  "x3270"
  "wstunnel"
  "samba"
  "cutter"
  "copacetic"
  "nfswolf"
  "pspy"
  "enum4linux"
  "enum4linux-ng"
  "thc-hydra"
  "legba"
  "theharvester"
  "das"
  "prowler"
  "checkov"
  "apkleaks"
  "adenum"
  "conpass"
  "ldapmonitor"
  "silenthound"
  "packj"
]
