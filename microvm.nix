# Guest NixOS configuration for the RedNix microVM (microvm.nix module).
# Exposed as packages.<system>.microvm — `nix run .#microvm`.
{ rednixPackages, ... }: {
  networking = {
    hostName = "RedNix";
    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [
        22
        80
      ];
    };
  };

  environment.systemPackages = rednixPackages;

  nix.settings.extra-experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config = import ./nixpkgs-config.nix { };

  services = {
    getty.autologinUser = "rednix";
    openssh = {
      enable = true;
      settings.X11Forwarding = true;
    };
  };

  users.users.rednix = {
    isNormalUser = true;
    uid = 1000;
    description = "RedNix microVM user";
    initialPassword = "rednix";
    extraGroups = [ "wheel" ];
  };

  security.sudo.wheelNeedsPassword = false;

  microvm = {
    # qemu is the one hypervisor that runs on Linux (KVM) and macOS
    # (HVF) alike.
    hypervisor = "qemu";
    vcpu = 4;
    mem = 4096;
    socket = "control.socket";
    shares = [
      {
        proto = "9p";
        tag = "ro-store";
        source = "/nix/store";
        mountPoint = "/nix/.ro-store";
      }
    ];
    # Persistent /home/rednix on an auto-created ext4 image;
    # the rest of the guest stays stateless (ro-store + tmpfs)
    volumes = [
      {
        image = "rednix-home.img";
        mountPoint = "/home/rednix";
        # Sparse (truncate + mkfs.ext4), so the declared size costs ext4
        # metadata, not 64 GiB upfront.
        size = 65536;
      }
    ];
    interfaces = [
      {
        type = "user";
        id = "qemu";
        mac = "02:00:00:01:01:01";
      }
    ];
    forwardPorts = [
      {
        host.address = "127.0.0.1";
        host.port = 2222;
        guest.port = 22;
      }
      {
        host.address = "127.0.0.1";
        host.port = 8080;
        guest.port = 80;
      }
    ];
  };

  system.stateVersion = "25.11";
}
