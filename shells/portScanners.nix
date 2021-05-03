{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    arp-scan
    ipscan
    masscan
    naabu
    nmap
    nmap-graphical
    rustscan
    zmap      
  ];
}