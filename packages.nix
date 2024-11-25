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
      ghauri
      laudanum
      mongoaudit
      nosqli
      pysqlrecon
      sqlmap
    ];

    crypto = with pkgs; [
      (sage.override {
        requireSageTests = false;
        extraPythonPackages = p:
          with p; [
            pwntools
            pycryptodome
            gmpy2
          ];
      })
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
      dnspeep
      dnsx
      fierce
      findomain
      knockpy
      massdns
      subfinder
      subprober
      subzerod
      wtfis
    ];

    exploits = with pkgs; [
      exploitdb
      go-exploitdb
      keedump
      padre
      sploitscan
      
      # log4j-related
      lmp
      log4jcheck
      log4j-detect
      log4j-scan
      log4j-sniffer
      log4j-vuln-scanner
      logmap
    ];

    forensics = with pkgs; [
      afflib
      amoco
      acquire
      inputs.chainsaw.packages.${pkgs.stdenv.hostPlatform.system}.chainsaw
      dcfldd
      ddrescue
      ddrescueview
      dislocker
      dismember
      python3Packages.distorm3
      exiv2
      ext4magic
      extundelete
      foremost
      gef
      gzrt
      hivex
      hstsparser
      noseyparker
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
      # afl
      aflplusplus
      feroxbuster
      ffuf
      honggfuzz
      radamsa
      regexploit
      scout
      ssdeep
      wfuzz
      zzuf
      spike
    ];

    general = with pkgs; [
      chrony
      clamav
      curl
      cyberchef
      dorkscout
      easyeasm
      exiflooter
      flashrom
      girsh
      gtfocli
      htop
      httpie
      i2pd
      inetutils
      inxi
      iproute2
      iw
      lynx
      macchanger
      ngrok
      vim
      parted
      pwgen
      util-linux
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
      python3
      firefox-bin
      eza
      bat
      fd
      procs
      sd
      grex
      linux-exploit-suggester
    ];

    git = with pkgs; [
      bomber-go
      cargo-audit
      credential-detector
      deepsecrets
      detect-secrets
      freeze
      garble
      gitjacker
      gitleaks
      gitls
      git-secret
      gokart
      legitify
      osv-detector
      packj
      pip-audit
      python310Packages.safety
      secretscanner
      skjold
      tell-me-your-secrets
      # shhgit
      trufflehog
      whispers
      xeol
    ];

    hardware = with pkgs; [
      arduino
      cantoolz
      chipsec
      cmospwd
      esptool
      extrude
      gallia
      hachoir
      nrfutil
      teensy-loader-cli
      # python3Packages.angr
      # python3Packages.angrop
      python3Packages.can
      python3Packages.pyi2cflash
      python3Packages.pyspiflash
    ];

    ids = with pkgs; [
      teler
      waf-tester
      wafw00f
    ];

    info-gathering = with pkgs; [
      metabigor
      sn0int
      p0f
      theharvester
      urlhunter
      cloudbrute
      holehe
      # maigret
      metabigor
      socialscan
      enumerepo
      ntopng
      urlhunter
    ];

    cloud = with pkgs; [
      cloud-nuke
      cloudfox
      ec2stepshell
      gato
      gcp-scanner
      goblob
      imdshift
      pacu
      poutine
      prowler
      yatas
    ];

    kubernetes = with pkgs; [
      cfripper
      checkov
      cirrusgo
      kdigger
      kube-score
      kubeaudit
      kubestroyer
      kubescape
      popeye
    ];

    ldap = with pkgs; [
      python3Packages.ldapdomaindump
      adenum
      hekatomb
      msldapdump
      ldapmonitor
      ldapdomaindump
      ldapnomnom
      ldeep
      silenthound
    ];

    load-testing = with pkgs; [
      ali
      drill
      cassowary
      ddosify
      oha
      siege
      tsung
      vegeta
    ];

    misc = with pkgs; [
      ares-rs
      badchars
      changetower
      creds
      # deepsea
      doona
      galleta
      honeytrap
      jwt-cli
      kepler
      nmap-formatter
      pwntools
      python3Packages.pytenable
      snscrape
      sr2t
      sttr
      troubadix
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
      payload-dumper-go
      scrcpy
      simg2img
      trueseeing
    ];

    network = with pkgs; [
      arping
      atftp
      arpoison
      bandwhich
      bngblaster
      cdncheck
      netexec
      evillimiter
      ipcalc
      iperf2
      iputils
      lftp
      mitm6
      mtr
      ncftp
      netcat-gnu
      netexec
      netdiscover
      netkittftp
      netmask
      nload
      nuttcp
      p0f
      pingu
      putty
      pwnat
      responder
      route-graph
      rustcat
      sshping
      sslh
      tunnelgraf
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
      conpass
      crunch
      h8mail
      hashcat
      hashcat-utils
      hashdeep
      john
      medusa
      nasty
      ncrack
      nth
      phrasendrescher
      # python3Packages.patator
      thc-hydra
      truecrack
      chntpw
      crowbar
      hcxtools
    ];

    port-scanners = with pkgs; [
      arp-scan
      das
      ipscan
      masscan
      naabu
      nmap
      udpx
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
      # cutter
      flare-floss
      gdb
      ghidra-bin
      ioc-scan
      bytecode-viewer
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
      rizin
      stacks
      unicorn
      valgrind
      volatility3
      xortool
      yara
      zkar
      zydis
    ];

    services = with pkgs; [
      acltoolkit
      checkip
      ghunt
      ike-scan
      keepwn
      metasploit
      nbutools
      nikto
      nuclei
      nuclei-templates
      openrisk
      osv-scanner
      siege
      traitor
      uncover
    ];

    email = with pkgs; [
      mx-takeover
      ruler
      swaks
      trustymail 
    ];

    smartcards = with pkgs; [
      cardpeek
      libfreefare
      mfcuk
      mfoc
      python3Packages.emv
    ];

    snmp = with pkgs; [
      braa
      onesixtyone
      snmpcheck
    ];

    sql = with pkgs; [sqlmap];

    ssh = with pkgs; [
      baboossh
      sshchecker
      ssh-audit
      ssh-mitm
    ];

    ssl-tls = with pkgs; [
      cero
      sslscan
      ssldump
      sslsplit
      sslstrip
      testssl
      tlsx
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
      zellij
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
      joincap
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
      linux-exploit-suggester
      lynis
      safety-cli
      # tracee
      vulnix
    ];

    web = with pkgs; [
      arjun
      bettercap
      brakeman
      burpsuite
      # cameradar
      cansina
      cariddi
      chopchop
      clairvoyance
      commix
      corsair
      crackql
      crlfsuite
      dalfox
      dirstalk
      dirb
      dismap
      dontgo403
      ettercap
      forbidden
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
      python3Packages.hakuin
      nodePackages.hyperpotamus
      jaeles
      jsubfinder
      jwt-hack
      katana
      kiterunner
      mantra
      mitmproxy
      mitmproxy2swagger
      monsoon
      mubeng
      nikto
      ntlmrecon
      offat
      photon
      plecost
      proxify
      proxychains
      python3Packages.corsair-scan
      redsocks
      rshijack
      scraper
      slowlorust
      snallygaster
      subjs
      swaggerhole
      uddup
      wad
      webanalyze
      websecprobe
      whatweb
      wprecon
      wpscan
      wsrepl
      wuzz
      xcrawl3r
      xnlinkfinder
      xsubfind3r
      zap
      davtest
    ];

    windows = with pkgs; [
      adidnsdump
      adreaper
      certipy
      bloodhound-py
      breads-ad
      certi
      certipy
      certsync
      coercer
      donpapi
      enum4linux
      enum4linux-ng
      erosmb
      evil-winrm
      go365
      gomapenum
      kerbrute
      knowsmore
      lil-pwny
      nbtscan
      nbtscanner
      offensive-azure
      python3Packages.lsassy
      python3Packages.pypykatz
      rdwatool
      samba
      smbmap
      smbscan
    ];

    wireless = with pkgs; [
      aircrack-ng
      airgeddon
      bully
      cowpatty
      dbmonster
      horst
      killerbee
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
