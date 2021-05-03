{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    badtouch
    bruteforce-luks
    brutespray
    crunch
    hashcat
    hashcat-utils
    hashdeep
    john
    medusa
    nasty
    ncrack
    phrasendrescher
    python38Packages.patator
    thc-hydra
    chntpw
    crowbar
    hcxtools         
  ];
}