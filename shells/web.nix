{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    monsoon
    galer
    gau
    corsmisc
    bypass403
    subjs
    photon
    ntlmrecon
    wad
    httpx
    snallygaster
    hakrawler
    wuzz
    uddup
    sigurlx
    gospider
    wprecon
    wpscan
    bettercap
    burpsuite
    ettercap
    mitmproxy
    proxify
    proxychains
    redsocks
    rshijack
    zap
    dirb
    gobuster
  ];
}