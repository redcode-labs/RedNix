{ config, pkgs, lib, inputs, ... }:
  {
    containers = {
      rednix =
      let get-host-ip = "$(ip route | grep default | cut -d' ' -f3)";
      in {

        privateNetwork = true;
        hostAddress = "192.168.100.2";
        localAddress = "192.168.100.11";

        forwardPorts = [
          {
            containerPort = 22;
            hostPort = 2222;
            protocol = "tcp";
          }
          {
            containerPort = 80;
            hostPort = 8080;
            protocol = "tcp";
          }
        ];

        bindMounts = {
          "/" = {
            hostPath = "/mnt/rednix";
            isReadOnly = false;
          };
        };

        config = { config, pkgs, lib, inputs, ... }: {
        imports = [ ./packages.nix ];

        environment = {
          shellInit = "export DISPLAY=${get-host-ip}:0";
        };

        boot = {
          isContainer = true;
        };

        networking = {
          nat = {
            enable = true;
            internalInterfaces = [ "ve-rednix" ];
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

        nix = {
          package = pkgs.nixUnstable;
          extraOptions = ''
            experimental-features = nix-command flakes
          '';
        };

        # packages
        nixpkgs = {
          config = {
            allowUnfree = true;
          };
        };

        # services
        services = {
          getty = {
            autologinUser = "rednix";
          };
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
            allowedAccess = [];
            interfaces = [];
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
              extraGroups =
                [ "wheel" ];
            };
          };
        };
        };
      };
    };
  }