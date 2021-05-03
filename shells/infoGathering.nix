{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    sn0int
    p0f
    theharvester
    urlhunter
    cloudbrute
    ntopng         
  ];
}