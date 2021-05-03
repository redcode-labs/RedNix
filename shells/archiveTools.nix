{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    cabextract
    p7zip
    unrar
    unzip         
  ];
}