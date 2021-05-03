{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    chrony
    clamav
    curl
    flashrom
    htop
    httpie
    inetutils
    inxi
    iproute
    iproute2
    iw
    lynx
    macchanger
    vim
    parted
    pwgen
    utillinux
    wget
    coreutils
    killall
    usbutils
    ntfs3g
    ripgrep
    ripgrep-all
    ranger
    file         
  ];
}