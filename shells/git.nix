{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    gitjacker
    truffleHog
    gitleaks
    shhgit
    secretscanner
  ];
}