{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    cipherscan
    ssldump
    sslsplit
    sslyze
    testssl
    sslscan
    ssl-cert-check
  ];
}