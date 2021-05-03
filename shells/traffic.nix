{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    anevicon
    dhcpdump
    dnstop
    driftnet
    dsniff
    goreplay
    httpdump
    junkie
    netsniff-ng
    ngrep
    sniffglue
    tcpdump
    tcpflow
    tcpreplay
    termshark
    tshark
    wireshark
    wireshark-cli
    zeek
  ];
}