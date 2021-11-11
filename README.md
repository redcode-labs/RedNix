<h1 align="center"> RedNix </h1>
<div align="center">
  <img src="logo.png" width="333"><br>
  Hackable NixOS container preloaded with tools for security auditors</a><br>
  <img src="https://builtwithnix.org/badge.svg">
</div>

## What is this project

This is a NixOS container pre-loaded with tools for security auditors, ethical hackers, CTF players and other people interested in infosec.

The goal is to have a reproducible NixOS container, so one can use it in many instances on many NixOS machines and have an identical working environment.

## What if I don't have NixOS

Don't worry. You can find nix-shells in `./shells` directory. They'll work fine platform-wide. You can find more info about that in README [here](./shells/README.md)

NixOS Vagrant container will also do the job and will be able to run this container.

## Features

This NixOS container is done in declarative-way. Basically, this can be used as an isolation of system(-ish) services, so you can separate container from your currently running system.

Note: NixOS containers are **NOT** perfectly isolated environments. User with root access to the container, can affect the host.

Do **NOT** give container root access to untrusted users.

It provides more options than a regular, imperative NixOS container. You can, for example, specify container and it's config in host's system config (usually that's just `configuration.nix`).

Note: You can still use it the imperative way, using `nixos-container` tool. I'll describe it, as well as declarative way in [installation and usage](#installation-and-usage) section.

## Installation and usage

Note: all commands mentioned here should be run as root

### Imperative way

Note: some features of this container *can* be limited if you go imperative way.

You can just clone this repo and then:

`nixos-container create rednix`

That will create a container, but it won't start it. To start the container, run:

`nixos-container start rednix`

To check the status of it, do:

`systemctl status container@rednix`

If it started, you can login:

`nixos-container root-login rednix`

### Declarative way

As I've mentioned earlier, this container can be added to your system config.

When you run `nixos-rebuild switch`, your container will be built.

Furthermore, if the container was running, it will be updated without rebooting.

You can autostart it as well, if you add the following to your system config:

```nix
containers.rednix.autoStart = true;
```

### Configuration

This container can be configured to your needs. Whether you just want less packages or more fancy things, such as port forwarding.

#### Networking

By default, next free address in `10.233.0.0/16` subnet will be container's IP. You can edit this, doing, for instance:

`nixos-container create rednix --config-file configuration.nix --local-address 10.235.1.2 --host-address 10.235.1.1`

If you create a container using `nixos-container create`, it will get it's own private IPv4 in the range mentioned before.

To check container's IPv4, do:

`nixos-container show-ip rednix`

The network interface inside the container is called `eth0`, and the matching interface on host is called `ve-rednix`. It can perform arbitraty network configuration, for example, setting up firewall rules, without affecting host.

That was an imperative way.

If you need to talk to the outside network with RedNix, it's done with Network Address Translation rules aka NAT. RedNix comes with this pre-configured as following:

```nix
networking = {
  nat = {
    enable = true;
    internalInterfaces = [ "ve-rednix" ];
    externalInterface = "eth0";
  };
};
```

Little notes:

* `eth0` should be replaced with the desired external interface's name.

* `ve-+` will match all containers interfaces if that's your thing.

* if you're using Network Manager as I do, prevent it from managing container interfaces:

```nix
networking.networkmanager.unmanaged = [ "interface-name:ve-*" ];
```

Now, time for the declarative way.

RedNix comes with pre-configured IP addresses as examples in it's `configuration.nix` file:

```nix
privateNetwork = true;
hostAddress = "192.168.100.2";
localAddress = "192.168.100.11";
```

You can also do port forwarding inside the container. This can be achieved doing:

```nix
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
```

As you can see, RedNix comes with a little, preloaded config there.

Furthermore, you can change the protocol which is used to forward ports.

If you're going declarative way, you just need to edit lines mentioned above and you'll be fine. Remember to `nixos-rebuild switch` in order to apply changes made to container's configuration.

Note: if you're going declarative way, container will share network namespace of the host. Given that, they can listen on priviliged ports. But they can **NOT** change the network config.

Lines mentioned above will give container a private virtual Ethernet interface with address `192.168.100.11`, which is hooked up to a virtual Ethernet interface on the host with IP address `192.168.100.10`.

### Updating

You can just rebuild your host system as following:
`nixos-rebuild switch`

But you can as well run `nixos-rebuild switch` inside the container.

Note: container does **NOT** have the copy of NixOS channel inside itself, in order to fix it, firstly run:

`nix-channel --update`

You can also edit configuration found under `/var/lib/container/rednix/etc/nixos` directory and then perform:

`nixos-container update rednix`

Which will build and activate new config.

### Usage

You can start a container using:

`nixos-container start rednix`

As well as stop it, using:

`nixos-container stop rednix`

Both of the examples mentioned above are done in imperative way.

If you want to start a declarative container, do:

`systemctl start container@rednix`

And, respectievely, if you want to stop them, do:

`systemctl stop container@rednix`

In order to disable declarative container, remove it's part from your `configuration.nix` and don't forget to `nixos-rebuild switch`. This will delete the root directory of RedNix in `/var/lib/containers` directory.

Containers, done both imperative and declarative way, can be destroyed using imperative way:

`nixos-container destroy rednix`

## Other projects

This project was influenced by [Kalinix](https://github.com/balsoft/kalinix) made by [@balsoft](https://github.com/balsoft), which takes an imperative approach to similar problem.

The structure of packages and their categories in nix-shells and their order in `packages.nix` was heavily influenced by [nix-security-box](https://github.com/fabaff/nix-security-box) by [@fabaff](https://github.com/fabaff)

## More

If you want to learn more, you might want to check the official NixOS container docs [here](https://nixos.org/manual/nixos/unstable/index.html#ch-containers)
