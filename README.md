<h1 align="center"> RedNix </h1> <div align="center"> <img src="logo.png"
width="333"><br> Hackable NixOS container preloaded with tools for security
auditors</a><br> <img src="https://builtwithnix.org/badge.svg"> </div>

## What is this project

This is a NixOS container pre-loaded with tools for security auditors, ethical
hackers, CTF players and other people interested in infosec.

The goal is to have a reproducible NixOS container, so one can use it in many
instances on many NixOS machines and have an identical working environment.

## What if I don't have NixOS

Don't worry. You can use devShells. They will work fine on any Linux system. You
can find more info about them in their [README](./shells/README.md)

The NixOS Vagrant container will also do the job and will be able to run this
container.

## Features

This NixOS container is done in declarative-way. Basically, this can be used as
an isolation of system services, so you can separate the container from your
currently running system.

Note: NixOS containers are **NOT** perfectly isolated environments. Users with
root access to the container can affect the host.

Do **NOT** give container root access to untrusted users.

It provides more options than a regular, imperative NixOS container. You can,
for example, specify the container and its config in the host's system config.

Note: You can still use it the imperative way, using the `nixos-container` tool.
It is described along the declarative way in the next section.

## Installation and usage

**Note**: all commands mentioned here should be run as root

### Imperative

Note: some features of this container *can* be limited if you go imperative way.

```bash
nixos-container create --flake github:redcode-labs/rednix#<arch> rednix
```
Where `<arch>` is one of `{aarch64,x86_64}-{linux,darwin}`.

That will create a container, but it won't start it. To start the container,
run:

```bash
nixos-container start rednix
```

To check the status of it, do:

```bash
systemctl status container@rednix
```

If it started, you can login:

```bash
nixos-container root-login rednix
```

### Declarative

As mentioned earlier, this container can be added to your system config.
To do this, you have to add `RedNix` as an input to your system flake, then
include `container` in your config like this:

```nix
# system configuration
{ config, pkgs, inputs, ... }: {
  imports = [ inputs.rednix.container ];
}
```

When you run `nixos-rebuild switch`, your container will be built.

Furthermore, if the container was running, it will be updated without rebooting.

You can autostart it as well, if you add the following to your system config:

```nix
containers.rednix.autoStart = true;
```

### Configuration

This container can be configured to your needs. Whether you just want less
packages or more fancy things, such as port forwarding.

#### Networking

By default, next free address in `10.233.0.0/16` subnet will be container's IP.
You can edit this, doing, for instance:

```bash
nixos-container create --flake github:redcode-labs/rednix#<arch> rednix --local-address 10.235.1.2 --host-address 10.235.1.1
```

If you create a container using `nixos-container create`, it will get its own
private IPv4 in the range mentioned before.

To check container's IPv4, do:

```bash
nixos-container show-ip rednix
```

The network interface inside the container is called `eth0`, and the matching
interface on host is called `ve-rednix`. It can perform arbitraty network
configuration, for example, setting up firewall rules, without affecting the
host.

If you need to talk to the outside network with RedNix, you can do so with
Network Address Translation rules aka NAT. RedNix comes with this pre-configured
like this:

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

* `eth0` should be replaced with the desired external interface name.

* `ve-+` will match all containers' interfaces.

* If you're using Network Manager, prevent it from managing container
interfaces:

```nix
networking.networkmanager.unmanaged = [ "interface-name:ve-*" ];
```

Now, time for the declarative way.

RedNix comes with pre-configured IP addresses as examples in its
`configuration.nix` file:

```nix
privateNetwork = true;
hostAddress = "192.168.100.2";
localAddress = "192.168.100.11";
```

You can also do port forwarding inside the container. This can be achieved by
doing:

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

As you can see, RedNix comes with a little preloaded config there.

Furthermore, you can change the protocol used to forward ports.

If you're going the declarative way, you just need to edit the lines mentioned
above and you'll be fine. Remember to `nixos-rebuild switch` in order to apply
changes made to the container's configuration.

Note: if you're going the imperative way, container will share the network
namespace of the host. Given that, they can listen on priviliged ports. But they
can **NOT** change the network config.

Lines mentioned above will give the container a private virtual Ethernet
interface with address `192.168.100.11`, which is hooked up to a virtual
Ethernet interface on the host with IP address `192.168.100.10`.

### Updating

You can just rebuild your host system as following:
```bash
nixos-rebuild switch
```

But you can as well run `nixos-rebuild switch` inside the container.

You can also edit configuration found under
`/var/lib/container/rednix/etc/nixos` directory and then perform:

```bash
nixos-container update rednix
```

Which will build and activate the new config.

### Usage

You can start/stop a container imperatively using:

```bash
nixos-container start/stop rednix
```

If you want to start/stop a declarative container, do:

`systemctl start/stop container@rednix`

In order to disable the declarative container, remove its part from your
system config and `nixos-rebuild switch`. This will delete the root directory
of RedNix from `/var/lib/containers` directory.

Containers, done both imperatively and declaratively, can be destroyed
imperatively:

```bash
nixos-container destroy rednix
```

## Other projects

This project was influenced by [Kalinix](https://github.com/balsoft/kalinix)
made by [@balsoft](https://github.com/balsoft), which takes an imperative
approach to similar problem.

The structure of packages and their categories in devShells and their order in
`packages.nix` was heavily influenced by [nix-security-box](https://github.com/fabaff/nix-security-box)
by [@fabaff](https://github.com/fabaff).

## More

If you want to learn more, you might want to check the official NixOS container
docs [here](https://nixos.org/manual/nixos/unstable/index.html#ch-containers).
