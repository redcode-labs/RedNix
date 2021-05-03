{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    cifs-utils
    freerdp
    mosh
    net-snmp
    nfs-utils
    ntp
    openssh
    openvpn
    samba
    tightvnc
    wireguard
    wireguard-go
    wireguard-tools
    xrdp
  ];
}