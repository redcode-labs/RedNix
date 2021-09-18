{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    enum4linux
    enum4linux-ng
    ike-scan
    python39Packages.ldapdomaindump
    ldeep
    metasploit
    nikto
    nuclei
    onesixtyone
    siege
    swaks
    traitor
    wafw00f
  ];
}
