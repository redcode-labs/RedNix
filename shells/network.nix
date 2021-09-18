{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  nativeBuildInputs = [
    netkittftp
    atftp
    evillimiter
    iperf2
    lftp
    mtr
    ncat
    ncftp
    netcat-gnu
    nload
    nuttcp
    putty
    pwnat
    sshping
    sslh
    telnet
    wbox
    whois
    ipcalc
    netmask
  ];
}
