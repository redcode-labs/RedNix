{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    checksec
    chkrootkit
    lynis
    vulnix
  ];
}