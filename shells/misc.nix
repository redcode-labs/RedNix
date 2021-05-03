{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    badchars
    deepsea
    honeytrap
    pwntools         
  ];
}