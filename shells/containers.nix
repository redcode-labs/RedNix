{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    clair
    dockle
    grype
    trivy
    fwanalyzer         
  ];
}