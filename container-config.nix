{
  pkgs,
  inputs,
  ...
}: let
  get-host-ip = "$(ip route | grep default | cut -d' ' -f3)";
in {
  boot.isContainer = true;

  environment = {
    shellInit = "export DISPLAY=${get-host-ip}:0";
    systemPackages = builtins.concatLists (builtins.attrValues (import ./packages.nix {inherit pkgs inputs;}));
  };

  networking = {
    nat = {
      enable = true;
      internalInterfaces = ["ve-rednix"];
      externalInterface = "eth0";
    };
    useDHCP = false;
    hostName = "RedNix";
    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [];
    };
  };

  # nix config
  nix = {
    settings.extra-experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # nixpkgs config
  nixpkgs.config = {
    allowUnfree = true;
    allowInsecurePredicate = p: true;
    segger-jlink.acceptLicense = true;
  };

  # services
  services = {
    getty.autologinUser = "rednix";

    openssh = {
      enable = true;
      settings.X11Forwarding = true;
    };

    avahi = {
      enable = true;
      browseDomains = [];
      wideArea = false;
      nssmdns = true;
    };

    unbound = {
      enable = true;
      settings.server = {};
    };
  };

  system.stateVersion = "23.11";

  # users
  users.users.rednix = {
    isNormalUser = true;
    uid = 1000;
    description = "RedNix container user";
    password = "rednix";
    extraGroups = ["wheel"];
  };
}
