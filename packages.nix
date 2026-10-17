{
  pkgs,
  inputs,
  # Per-source toggles
  usePwndbg ? true,
  useNrfutil ? true,
  useNixAlien ? true,
}:
let
  system = pkgs.stdenv.hostPlatform.system;
  pwndbgForSystem =
    if usePwndbg && inputs.pwndbg.packages ? ${system} then
      [ inputs.pwndbg.packages.${system}.pwndbg ]
    else
      [ ];
  # nrfutil's meta.platforms claims aarch64-linux but its source actually
  # references attributes that only exist for x86_64-linux, so any access
  # (including pname) throws an uncatchable "attribute missing" error there.
  # Restrict it to systems where it actually evaluates.
  nrfutilForSystem = if useNrfutil && system == "x86_64-linux" then [ pkgs.nrfutil ] else [ ];
  # nix-alien is the escape hatch for offensive binaries not yet packaged
  nixAlienForSystem =
    if useNixAlien && inputs.nix-alien.packages ? ${system} then
      [ inputs.nix-alien.packages.${system}.nix-alien ]
    else
      [ ];
  packages = {
    RCL = with pkgs; [
      sammler
      gosh
      godspeed
      snowcrash
    ];

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
      trajan
    ];

    containers = with pkgs; [
      cdk-go
      clair
      cliam
      cloudlist
      copacetic
      dive
      dockle
      grype
      trivy
      fwanalyzer
      varunastra
    ];

    crypto = with pkgs; [
      (sage.override {
        requireSageTests = false;
        extraPythonPackages =
          p: with p; [
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
      dnsmonster
      dnsrecon
      dnstake
      dnstracer
      dnstwist
      dnspeep
      dnsx
      dnsvalidator
      domain-check
      fierce
      findomain
      knockpy
      massdns
      mhost
      puredns
      subcat
      subfinder
      subprober
      subzerod
      tldfinder
      tldx
      wtfis
    ];

    exploits = with pkgs; [
      exploitdb
      go-exploitdb
      keedump
      padre
      sploitscan

      # log4j-related (most upstream-removed since Log4Shell mitigation matured)
      lmp
      logmap
    ];

    forensics = with pkgs; [
      afflib
      amoco
      chainsaw
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
      gzrt
      hayabusa-sec
      hivex
      hstsparser
      malwoverview
      noseyparker
      ntfs3g
      nwipe
      recoverjpeg
      safecopy
      sleuthkit
      srm
      stegseek
      stegsolve
      testdisk
      unblob
      wipe
      xorex
      capstone
      pdf-parser
    ];

    fuzzers = with pkgs; [
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
    ];

    general = with pkgs; [
      bat
      btop
      certinfo-go
      chrony
      clamav
      coreutils
      curl
      cyberchef
      dorkscout
      easyeasm
      exiflooter
      eza
      fd
      file
      firefox-bin
      flashrom
      girsh
      grex
      gtfocli
      htop
      http-server
      httpie
      hurl
      i2pd
      iftop
      inetutils
      inxi
      iotop
      iproute2
      iw
      killall
      lynx
      macchanger
      nano
      ngrok
      parted
      procs
      pspy
      pwgen
      python3
      ranger
      ripgrep
      ripgrep-all
      ronin
      sd
      shellz
      spyre
      tor
      torsocks
      usbutils
      util-linux
      vim
      wget
      xh
    ];

    git = with pkgs; [
      betterleaks
      bomber-go
      cargo-audit
      corrode-scanner
      credential-detector
      detect-secrets
      errcheck
      freeze
      garble
      gitjacker
      gitleaks
      gitls
      git-secret
      gitxray
      gokart
      hexora
      kingfisher
      legitify
      osv-detector
      packj
      pip-audit
      secrethound
      secretscanner
      skjold
      tell-me-your-secrets
      trufflehog
      whispers
      xeol
      zentra
    ];

    hardware =
      nrfutilForSystem
      ++ (with pkgs; [
        arduino
        cantoolz
        cmospwd
        embedxpl
        esptool
        extrude
        gallia
        hachoir
        mithril
        moria
        packetry
        teensy-loader-cli
        termineter
        tytools
        python3Packages.python-can
        python3Packages.pyi2cflash
        python3Packages.pyspiflash
      ]);

    ids = with pkgs; [
      teler
      waf-tester
      wafw00f
    ];

    info-gathering = with pkgs; [
      cloudbrute
      enumerepo
      exposor
      holehe
      lse
      maigret
      metabigor
      ntopng
      raccoon-scanner
      recon-ng
      sherlock
      sn0int
      socialscan
      theharvester
      urlhunter
      xnldorker
    ];

    cloud = with pkgs; [
      agneyastra
      cloud-nuke
      cloudfox
      ec2stepshell
      gato
      gcp-scanner
      goblob
      grimoire
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
      kube-hunter
      kube-score
      kubeaudit
      kubestroyer
      kubescape
      peirates
      popeye
    ];

    ldap = with pkgs; [
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
      doona
      galleta
      honeytrap
      jwt-cli
      kepler
      nali
      nmap-formatter
      penelope
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
      ghost
      mobsf
      morf
      otadump
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
      cdncheck
      evillimiter
      ipcalc
      iperf2
      iputils
      jwhois
      lftp
      mdns-scanner
      mitm6
      mtr
      ncftp
      netcat-gnu
      netdiscover
      netkittftp
      netmask
      nfswolf
      nload
      nuttcp
      nxc-rs
      p0f
      pingu
      putty
      pwnat
      rdap
      responder
      route-graph
      rustcat
      sshping
      sslh
      tcping-rs
      tcptraceroute
      tunnelgraf
      wbox
      whois
      whosthere
      yersinia
    ];

    packet-generators = with pkgs; [
      boofuzz
      gping
      fping
      hping
      ostinato
      python3Packages.scapy
    ];

    passwords = with pkgs; [
      authoscope
      brutecraber
      bruteforce-luks
      brutespray
      cewl
      chntpw
      ciphey
      conpass
      crack-hash
      crowbar
      crunch
      h8mail
      hashcat
      hashcat-utils
      hashdeep
      hcxtools
      john
      legba
      medusa
      nasty
      ncrack
      nth
      phrasendrescher
      spearspray
      spraycharles
      thc-hydra
      truecrack
    ];

    port-scanners = with pkgs; [
      arp-scan
      arp-scan-rs
      asphyxia
      das
      havn
      ipscan
      lazynmap
      masscan
      naabu
      netscan
      nmap
      portwave
      rustscan
      smap
      sx-go
      udpx
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
      wtcat
      xrdp
    ];

    reporting = with pkgs; [
      cherrytree
      dos2unix
    ];

    reverse-engineering =
      with pkgs;
      pwndbgForSystem
      ++ [
        bingrep
        bytecode-viewer
        capa
        cutter
        flare-floss
        gdb
        gef
        ghidra-bin
        hacksguard
        hfinger
        imhex
        ioc-scan
        mono
        pev
        python3Packages.karton-core
        python3Packages.malduck
        python3Packages.r2pipe
        radare2
        reknife
        rizin
        stacks
        unicorn
        valgrind
        volatility3
        xortool
        yara
        yara-x
        zkar
        zydis
      ];

    services = with pkgs; [
      acltoolkit
      checkip
      ghunt
      ike-scan
      ikebuster
      keepwn
      metasploit
      mqattack
      nbutools
      nerva
      nuclei
      nuclei-templates
      openrisk
      osv-scanner
      traitor
      uncover
    ];

    email = with pkgs; [
      mx-takeover
      ruler
      smtpeek
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
      snmpen
    ];

    sql = with pkgs; [
      freetds
      ghauri
      laudanum
      mongoaudit
      nosqli
      pysqlrecon
      sqlcmd
      sqlmap
      sqlmc
      unixodbcDrivers.msodbcsql18
    ];

    ssh = with pkgs; [
      baboossh
      sshchecker
      ssh-audit
      ssh-mitm
    ];

    ssl-tls = with pkgs; [
      cero
      cryptoscan
      gsan
      mini-pqc
      pqc-bench
      pqcscan
      sslscan
      ssldump
      sslsplit
      sslstrip
      testssl
      tlsinfo
      tlsx
    ];

    supply-chain = with pkgs; [
      chain-bench
      qbom
      sh4d0wup
      witness
    ];

    terminals = with pkgs; [
      cutecom
      minicom
      picocom
      socat

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
      above
      dhcpdump
      dnstop
      driftnet
      dsniff
      fluere
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
      chisel
      corkscrew
      hans
      httptunnel
      iodine
      sish
      sshuttle
      stunnel
      udptunnel
      wstunnel
    ];

    unported-shims = nixAlienForSystem;

    voip = with pkgs; [
      sipp
      sipsak
      sipvicious
      sngrep
    ];

    vuln-analysis = with pkgs; [
      cert-x-gen
      checksec
      cve-prioritizer
      flawz
      linux-exploit-suggester
      lynis
      safety-cli
      search-vulns
      stave
      tracee
      vulnix
      vuls
    ];

    web = with pkgs; [
      albedo
      arjun
      atac
      bettercap
      brakeman
      burpsuite
      cameradar
      cansina
      cariddi
      cf-hero
      chopchop
      cogitator
      commix
      corsair
      crackql
      crlfsuite
      dalfox
      davtest
      dirstalk
      dirb
      dirbuster
      dismap
      ettercap
      forbidden
      galer
      gau
      genzai
      gobuster
      gospider
      gotestwaf
      gowitness
      graphpython
      graphqlmaker
      graphqlmap
      graphw00f
      h2spec
      hakrawler
      hey
      httpx
      python3Packages.hakuin
      hyperpotamus
      introspectre
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
      nomore403
      ntlmrecon
      offat
      photon
      plecost
      proxify
      proxychains
      redsocks
      rshijack
      scraper
      slowlorust
      snallygaster
      subjs
      swaggerhole
      terminus-rs
      uddup
      urlfinder
      urx
      wad
      wappalyzergo
      webanalyze
      websecprobe
      whatweb
      wprecon
      wpscan
      wsrepl
      wuzz
      xcrawl3r
      xnlinkfinder
      xssearch
      xsstrike
      xsubfind3r
      zap
    ];

    windows = with pkgs; [
      adidnsdump
      adreaper
      autobloody
      azurehound
      bloodhound-ce
      bloodhound-py
      certi
      certipy
      certsync
      coercer
      credwolf
      donpapi
      enum4linux
      enum4linux-ng
      erosmb
      evil-winrm
      evil-winrm-py
      ghosthound
      go365
      gomapenum
      kerbrute
      kerbwolf
      knowsmore
      lil-pwny
      nbtscan
      nbtscanner
      ntdswolf
      offensive-azure
      powerview
      pre2k
      python3Packages.lsassy
      python3Packages.pypykatz
      pywhisker
      rdwatool
      sccmhunter
      sharefinder
      skewrun
      smbmap
      smbscan
      taskhound
    ];

    wireless = with pkgs; [
      aircrack-ng
      airgeddon
      airgorah
      bully
      cowpatty
      dbmonster
      gqrx
      hcxdumptool
      horst
      kalibrate-hackrf
      kalibrate-rtl
      killerbee
      kismet
      multimon-ng
      netscanner
      pixiewps
      reaverwps
      reaverwps-t6x
      sniffcrack
      wavemon
      wepwolf
      wifite2
      wpawolf
      zigpy-cli
    ];
  };
in
packages
