{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    afl
    aflplusplus
    ffuf
    honggfuzz
    radamsa
    ssdeep
    wfuzz
    zzuf
    spike             
  ];
}