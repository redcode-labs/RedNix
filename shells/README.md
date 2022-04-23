# RedNix devShells

## Why devShells?

Well, NixOS container will work only under NixOS (including Vagrant container).
Given so, our tool would be kinda useless on other distros.
That's why we've added a collection of Nix devShells, reproducible environments with specific sets of tools inside them.

## How to use

If you want to run `nix develop`, you need to have Nix installed on your system, then, run it doing, for example:

`nix develop .#general`

This will put you into an environment with packages provided in the `general` shell (see `packages.nix`).

Feel free to edit the shells to make them suit your needs.

You can combine sets of packages declared inside more than one nix-shell, using:

`nix develop .#{general,voip}`

## More

If you want to learn more about nix shells, check out wiki entry for them [here](https://nixos.wiki/wiki/Development_environment_with_nix-shell)
