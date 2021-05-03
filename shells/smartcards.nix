{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    cardpeek
    libfreefare
    mfcuk
    mfoc
  ];
}