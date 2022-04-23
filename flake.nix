{
  description = "RedNix Hackable NixOS Container";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }: let
    supportedSystems = ["aarch64-linux" "aarch64-darwin" "x86_64-darwin" "x86_64-linux"];
    genSystems = nixpkgs.lib.genAttrs supportedSystems;
    pkgs = genSystems (system: import nixpkgs {inherit system;});
  in {
    # auto-generated devShells
    devShells = genSystems (system: import ./shells pkgs.${system});

    # use with nixos-container
    nixosConfigurations = genSystems (system:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [./container.nix];
      });

    # import into your config for declarative containers
    container = ./container.nix;
  };
}
