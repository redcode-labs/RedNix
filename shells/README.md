# RedNix nix-shells

## Why nix-shells?

Well, NixOS container will work only under NixOS (including Vagrant container).
Given so, our tool would be kinda useless on other distros.
That's why we've added a collection of nix-shells, reproducible environments with specific sets of tools inside them.

## How to use it?

If you want to run nix-shell, you need to have Nix installed on your system, then, run it doing, for example:

`nix-shell general.nix`

This will jump you into nix-shells with packages provided in `general.nix`.

Feel free to edit nix-shells to make them suit your needs.

You can combine sets of packages declared inside more than one nix-shell, using:

`nix-shell general.nix voip.nix`

## More

If you want to learn more about nix-shells, check out wiki entry for them [here](https://nixos.wiki/wiki/Development_environment_with_nix-shell)
