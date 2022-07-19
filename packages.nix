pkgs: let
  packages = {
    archive-tools = with pkgs; [
      cabextract
      p7zip
      unrar
      unzip
    ];

    bluetooth = with pkgs; [
      bluez
      python3Packages.bleak
    ];

    containers = with pkgs; [
      clair
      dockle
      grype
      trivy
      fwanalyzer
    ];

    dns = with pkgs; [
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
    ];

    forensics = with pkgs; [
      afflib
      dcfldd
      ddrescue
      ddrescueview
      dislocker
      python3Packages.distorm3
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
    ];

    fuzzers = with pkgs; [
      afl
      aflplusplus
      ffuf
      honggfuzz
      radamsa
      ssdeep
      wfuzz
      zzuf
      spike
    ];

    general = with pkgs; [
      chrony
      clamav
      curl
      flashrom
      htop
      httpie
      i2pd
      inetutils
      inxi
      iproute
      iproute2
      iw
      lynx
      macchanger
      ngrok
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
      tor
      torsocks
    ];

    git = with pkgs; [
      gitjacker
      trufflehog
      gitleaks
      shhgit
      secretscanner
    ];

    hardware = with pkgs; [
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
    ];

    ids = with pkgs; [teler];

    info-gathering = with pkgs; [
      sn0int
      p0f
      theharvester
      urlhunter
      cloudbrute
      ntopng
    ];

    kubernetes = with pkgs; [
      checkov
      kube-score
    ];

    misc = with pkgs; [
      badchars
      deepsea
      honeytrap
      pwntools
    ];

    mobile = with pkgs; [
      abootimg
      apktool
      dex2jar
      genymotion
      python3Packages.androguard
      simg2img
    ];

    network = with pkgs; [
      netkittftp
      atftp
      evillimiter
      iperf2
      lftp
      mtr
      ncftp
      netcat-gnu
      nload
      nuttcp
      putty
      pwnat
      sshping
      sslh
      wbox
      whois
      ipcalc
      netmask
    ];

    packet-generators = with pkgs; [
      gping
      fping
      hping
      ostinato
      pktgen
      python3Packages.scapy
    ];

    passwords = with pkgs; [
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
    ];

    port-scanners = with pkgs; [
      arp-scan
      ipscan
      masscan
      naabu
      nmap
      rustscan
      zmap
    ];

    protocols = with pkgs; [
      cifs-utils
      freerdp
      mosh
      net-snmp
      nfs-utils
      ntp
      openssh
      openvpn
      samba
      tigervnc
      wireguard-go
      wireguard-tools
      xrdp
    ];

    reporting = with pkgs; [
      cherrytree
      dos2unix
    ];

    reverse-engineering = with pkgs; [
      bingrep
      gdb
      ghidra-bin
      mono
      pev
      pwndbg
      radare2
      radare2-cutter
      jd-gui
      valgrind
    ];

    services = with pkgs; [
      enum4linux
      enum4linux-ng
      ike-scan
      python3Packages.ldapdomaindump
      ldeep
      metasploit
      nikto
      nuclei
      onesixtyone
      siege
      swaks
      traitor
      wafw00f
    ];

    smartcards = with pkgs; [
      cardpeek
      libfreefare
      mfcuk
      mfoc
    ];

    snmp = with pkgs; [
      onesixtyone
    ];

    sql = with pkgs; [sqlmap];

    ssh = with pkgs; [
      sshchecker
      ssh-audit
      ssb
    ];

    ssl-tls = with pkgs; [
      ssldump
      sslsplit
      #sslyze # was removed for some reason
      testssl
    ];

    terminals = with pkgs; [
      cutecom
      minicom
      picocom
      socat
      x3270
      tmate

      # multiplexers
      screen
      tmux
    ];

    terraform = with pkgs; [
      terrascan
      tfsec
    ];

    traffic = with pkgs; [
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
      python3Packages.pyshark
      wireshark
      wireshark-cli
      zeek
    ];

    tunnels = with pkgs; [
      corkscrew
      hans
      chisel
      httptunnel
      iodine
      sish
      stunnel
      udptunnel
      wstunnel
    ];

    voip = with pkgs; [
      sipp
      sipsak
      sipvicious
    ];

    vuln-analysis = with pkgs; [
      checksec
      chkrootkit
      lynis
      vulnix
    ];

    web = with pkgs; [
      monsoon
      galer
      gau
      subjs
      photon
      ntlmrecon
      wad
      httpx
      snallygaster
      hakrawler
      wuzz
      uddup
      gospider
      # wprecon # broken
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
    ];

    windows = with pkgs; [
      python3Packages.pypykatz
      nbtscanner
    ];

    wireless = with pkgs; [
      aircrack-ng
      bully
      cowpatty
      horst
      kismet
      pixiewps
      reaverwps
      reaverwps-t6x
      wavemon
      wifite2
      util-linux
      gqrx
      kalibrate-hackrf
      kalibrate-rtl
      multimon-ng
    ];
  };
in
  packages
