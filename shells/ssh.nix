{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    sshchecker
    ssh-audit
    ssb
  ];
}