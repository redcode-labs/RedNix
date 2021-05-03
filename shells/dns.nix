{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    aiodnsbrute
    amass
    bind
    dnsenum
    dnsrecon
    dnstracer
    dnstwist
    dnsx
    fierce
    findomain
    knockpy
    subfinder
  ];
}