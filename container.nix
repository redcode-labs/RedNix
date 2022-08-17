{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  get-host-ip = "$(ip route | grep default | cut -d' ' -f3)";
in {
  boot = {
    isContainer = true;
  };

  environment = {
    shellInit = "export DISPLAY=${get-host-ip}:0";
  };

  environment.systemPackages = builtins.concatLists (builtins.attrValues (import ./packages.nix { inherit pkgs inputs; }));

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
    package = pkgs.nixUnstable;
    settings = {
      extra-experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  # nixpkgs config
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    allowInsecurePredicate = p: true;
  };

  # services
  services = {
    getty.autologinUser = "rednix";

    openssh = {
      enable = true;
      forwardX11 = true;
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

  # users
  users = {
    users = {
      rednix = {
        isNormalUser = true;
        uid = 1000;
        description = "RedNix container user";
        password = "rednix";
        extraGroups = ["wheel"];
      };
    };
  };
}
