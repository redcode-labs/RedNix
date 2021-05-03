{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    sipp
    sipsak
    sipvicious
  ];
}