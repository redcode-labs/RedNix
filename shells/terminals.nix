{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    cutecom
    minicom
    picocom
    socat
    x3270
    tmate
  ];
}