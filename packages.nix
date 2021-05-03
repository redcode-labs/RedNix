{ pkgs, fetchFromGitHub, ... }:

{
  environment.systemPackages = with pkgs; [

    # General
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

    # Misc
    badchars
    deepsea
    honeytrap
    pwntools

    # Mobile
    abootimg
    apktool
    dex2jar
    genymotion
    python39Packages.androguard
    simg2img

    # Hardware
    arduino
    cantoolz
    chipsec
    esptool
    hachoir
    python3Packages.angr
    python3Packages.angrop
    python3Packages.can
    python3Packages.pyi2cflash
    python3Packages.pyspiflash

    # Protocols
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

    # Network
    netkitftp
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

    # Port scanners
    arp-scan
    ipscan
    masscan
    naabu
    nmap
    nmap-graphical
    rustscan
    zmap

    # Packet generators
    gping
    fping
    hping
    ostinato
    pktgen
    scapy

    # Vul. analysis
    checksec
    chkrootkit
    lynis
    vulnix

    # SSL-TLS
    cipherscan
    ssldump
    sslsplit
    sslyze
    testssl

    # Traffic
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

    # Tunnels
    corkscrew
    hans
    chisel
    httptunnel
    iodine
    proxytunnel
    sish
    stunnel
    udptunnel
    wstunnel

    # VOIP
    sipp
    sipsak
    sipvicious

    # Wireless
    aircrack-ng
    bully
    cowpatty
    horst
    kismet
    pixiewps
    pyrit
    reaverwps
    reaverwps-t6x
    wavemon
    wifite2
    rfkill
    gqrx
    kalibrate-hackrf
    kalibrate-rtl
    multimon-ng

    # Information gathering
    sn0int
    p0f
    theharvester
    urlhunter
    cloudbrute
    ntopng

    # Reverse engineering
    bingrep
    gdb
    ghidra-bin
    pev
    pwndbg
    python39Packages.binwalk
    python39Packages.binwalk-full
    python39Packages.unicorn
    r2pipe
    radare2
    radare2-cutter
    unicorn
    unicorn-emu
    volatility
    xortool
    yara
    zydis
    jd-gui
    valgrind

    # Terminals
    cutecom
    minicom
    picocom
    socat
    x3270
    tmate

    # Terminal multiplexer
    screen
    tmux

    # Archive tools
    cabextract
    p7zip
    unrar
    unzip

    # Fuzzers
    afl
    aflplusplus
    ffuf
    honggfuzz
    radamsa
    ssdeep
    wfuzz
    zzuf
    spike

    # Forensics
    afflib
    dcfldd
    ddrescue
    ddrescueview
    dislocker
    distorm3
    exiv2
    ext4magic
    extundelete
    foremost
    gzrt
    hivex
    ntfs3g
    ntfsprogs
    nwipe
    recoverjpeg
    safecopy
    sleuthkit
    srm
    stegseek
    testdisk
    wipe
    xorex
    capstone
    pdf-parser

    # DNS
    aiodnsbrute
    amass
    bind
    dnsenum
    dnsrecon
    dnstracer
    dnstwist
    dnsx
    fierce
    findomain
    knockpy
    subfinder

    # Smartcards
    cardpeek
    libfreefare
    mfcuk
    mfoc

    # Bluetooth
    bluez
    bleak

    # Passwords
    badtouch
    bruteforce-luks
    brutespray
    crunch
    hashcat
    hashcat-utils
    hashdeep
    john
    medusa
    nasty
    ncrack
    phrasendrescher
    python38Packages.patator
    thc-hydra
    chntpw
    crowbar
    hcxtools

    # Reporting
    cherrytree
    dos2unix

    # Services
    enum4linux
    enum4linux-ng
    ike-scan
    ldapdomaindump
    ldeep
    metasploit
    nikto
    nuclei
    onesixtyone
    siege
    swaks
    traitor
    wafw00f

    # Git
    gitjacker
    truffleHog
    gitleaks
    shhgit
    secretscanner

    # *SQL
    sqlmap

    # Web, HTTP, proxies
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

    # SNMP
    onesixtyone

    # SSH
    sshchecker
    ssh-audit
    ssb

    # IDS
    teler

    # Container, images
    clair
    dockle
    grype
    trivy
    fwanalyzer

    # Terraform
    terrascan
    tfsec

    # Kubernetes
    checkov
    kube-score

    # Windows
    pypykatz
    nbtscanner
  ];
}