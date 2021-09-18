{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    gitjacker
    trufflehog
    gitleaks
    shhgit
    secretscanner
  ];
}
