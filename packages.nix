{
  pkgs,
  inputs,
}: let
  packages = {

    RCL = with pkgs; [
      sammler
      gosh
      godspeed
      snowcrash
    ];

    applePrincessPackages = pkgs.lib.mapAttrsToList (_: v: v) inputs.hackpkgs.packages.${pkgs.system};

    archive-tools = with pkgs; [
      cabextract
      p7zip
      unrar
      unzip
    ];

    bluetooth = with pkgs; [
      bluez
      python3Packages.bleak
      bluewalker
      redfang
      ubertooth
    ];

    ci = with pkgs; [
      oshka
    ];

    containers = with pkgs; [
      cdk-go
      clair
      cliam
      cloudlist
      dive
      dockle
      grype
      trivy
      fwanalyzer
    ];

    databases = with pkgs; [
      mongoaudit
      sqlmap
    ];

    dns = with pkgs; [
      aiodnsbrute
      amass
      bind
      dnsenum
      dnsmon-go
      dnsmonster
      dnsrecon
      dnstake
      dnstracer
      dnstwist
      dnsx
      fierce
      findomain
      knockpy
      subfinder
      subzerod
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
      gef
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
      feroxbuster
      ffuf
      honggfuzz
      radamsa
      regexploit
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
      xh
    ];

    git = with pkgs; [
      cargo-audit
      credential-detector
      detect-secrets
      gitjacker
      gitleaks
      gitls
      git-secret
      gokart
      osv-detector
      pip-audit
      python310Packages.safety
      secretscanner
      shhgit
      skjold
      trufflehog
      whispers
    ];

    hardware = with pkgs; [
      arduino
      cantoolz
      # chipsec
      esptool
      extrude
      hachoir
      python3Packages.angr
      python3Packages.angrop
      python3Packages.can
      python3Packages.pyi2cflash
      python3Packages.pyspiflash
    ];

    ids = with pkgs; [
      teler
      waf-tester
    ];

    info-gathering = with pkgs; [
      metabigor
      sn0int
      p0f
      theharvester
      urlhunter
      cloudbrute
      ntopng
      urlhunter
    ];

    kubernetes = with pkgs; [
      cfripper
      checkov
      kdigger
      kube-score
      kubeaudit
      kubescape
    ];

    ldap = with pkgs; [
      python3Packages.ldapdomaindump
      adenum
      ldapmonitor
      ldeep
    ];

    load-testing = with pkgs; [
      drill
      cassowary
      ddosify
      siege
      tsung
      vegeta
    ];

    misc = with pkgs; [
      badchars
      changetower
      deepsea
      doona
      honeytrap
      jwt-cli
      nmap-formatter
      pwntools
      python3Packages.pytenable
    ];

    mobile = with pkgs; [
      abootimg
      androguard
      apkeep
      apkleaks
      apktool
      dex2jar
      genymotion
      ghost
      simg2img
      trueseeing
    ];

    network = with pkgs; [
      arping
      atftp
      bandwhich
      crackmapexec
      evillimiter
      ipcalc
      iperf2
      lftp
      mtr
      ncftp
      netcat-gnu
      netdiscover
      netkittftp
      netmask
      nload
      # nuttcp
      p0f
      putty
      pwnat
      rustcat
      sshping
      sslh
      wbox
      whois
      yersinia
    ];

    packet-generators = with pkgs; [
      boofuzz
      gping
      fping
      hping
      ostinato
      pktgen
      python3Packages.scapy
    ];

    passwords = with pkgs; [
      badtouch
      authoscope
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
      nth
      phrasendrescher
      # python38Packages.patator
      thc-hydra
      truecrack
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
      sx-go
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
      step-cli
      tigervnc
      tightvnc
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
      cutter
      gdb
      ghidra-bin
      jd-gui
      mono
      pev
      pwndbg
      python3Packages.binwalk
      python3Packages.binwalk-full
      python3Packages.karton-core
      python3Packages.malduck
      python3Packages.r2pipe
      python3Packages.unicorn
      radare2
      radare2-cutter
      rizin
      stacks
      unicorn
      unicorn-emu
      valgrind
      volatility3
      xortool
      yara
      zkar
      zydis
    ];

    services = with pkgs; [
      enum4linux
      enum4linux-ng
      ike-scan
      # python3Packages.ldapdomaindump
      ldeep
      metasploit
      nikto
      nuclei
      checkip
      onesixtyone
      # siege
      swaks
      traitor
      # wafw00f
    ];

    smartcards = with pkgs; [
      cardpeek
      libfreefare
      mfcuk
      mfoc
      python3Packages.emv
    ];

    snmp = with pkgs; [
      onesixtyone
      snmpcheck
    ];

    sql = with pkgs; [sqlmap];

    ssh = with pkgs; [
      sshchecker
      ssh-audit
      ssh-mitm
      ssb
    ];

    ssl-tls = with pkgs; [
      ssldump
      sslsplit
      testssl
    ];

    supply-chain = with pkgs; [
      chain-bench
      witness
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
      secrets-extractor
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
      bore-cli
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
      sngrep
    ];

    vuln-analysis = with pkgs; [
      checksec
      chkrootkit
      lynis
      safety-cli
      tracee
      vulnix
    ];

    web = with pkgs; [
      bettercap
      brakeman
      burpsuite
      cameradar
      cariddi
      chopchop
      commix
      corsair
      crlfsuite
      dalfox
      dirb
      dismap
      dontgo403
      ettercap
      galer
      gau
      gobuster
      gospider
      gotestwaf
      gowitness
      graphqlmap
      graphw00f
      hakrawler
      hey
      httpx
      jaeles
      jsubfinder
      jwt-hack
      kiterunner
      mitmproxy
      mitmproxy2swagger
      monsoon
      mubeng
      nikto
      ntlmrecon
      photon
      proxify
      proxychains
      python3Packages.corsair-scan
      redsocks
      rshijack
      slowlorust
      snallygaster
      subjs
      swaggerhole
      uddup
      wad
      webanalyze
      whatweb
      wprecon
      wpscan
      wuzz
      zap
    ];

    windows = with pkgs; [
      adreaper
      certipy
      enum4linux
      enum4linux-ng
      erosmb
      evil-winrm
      go365
      gomapenum
      kerbrute
      nbtscanner
      offensive-azure
      python3Packages.pypykatz
      smbscan
    ];

    wireless = with pkgs; [
      aircrack-ng
      airgeddon
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
