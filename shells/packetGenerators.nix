{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    gping
    fping
    hping
    ostinato
    pktgen
    python39Packages.scapy
  ];
}
