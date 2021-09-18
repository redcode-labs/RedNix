{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    bluez
    python39Packages.bleak     
  ];
}
