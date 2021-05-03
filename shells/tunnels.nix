{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    corkscrew
    hans
    chisel
    httptunnel
    iodine
    proxytunnel
    sish
    stunnel
    udptunnel
    wstunnel
  ];
}