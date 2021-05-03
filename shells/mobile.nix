{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    abootimg
    apktool
    dex2jar
    genymotion
    python39Packages.androguard
    simg2img
  ];
}