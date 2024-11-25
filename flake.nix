{
  description = "My Nixos config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixdevsh.url = "github:mewsen/nixdevsh/master";
    nixos-hardware = { url = "github:NixOS/nixos-hardware/master"; };
  };

  outputs =
    { self, nixpkgs, nixpkgs-unstable, nixos-hardware, nixdevsh, ... }@inputs:
    let
      system = "x86_64-linux";
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forEachSupportedSystem = f:
        nixpkgs.lib.genAttrs supportedSystems
        (system: f { pkgs = import nixpkgs { inherit system; }; });
    in {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default =
          pkgs.mkShell { packages = with pkgs; [ nil nixfmt-classic ]; };
      });

      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit nixdevsh; };
          modules = [
            ./device/default/configuration.nix
            nixos-hardware.nixosModules.framework-13-7040-amd
            ({ config, pkgs, ... }: {
              nixpkgs.overlays = [ overlay-unstable ];
            })
          ];
        };
      };
    };
}
