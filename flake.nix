{
  description = "Minimal production-ready NixOS configuration for a Proxmox VM";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, ... }@inputs: {
    nixosConfigurations.capybara = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        disko.nixosModules.disko
        ./hosts/capybara/disko.nix
        ./hosts/capybara/configuration.nix
        ./hosts/capybara/hardware-configuration.nix
        ./modules/core.nix
        ./modules/users.nix
        ./modules/networking.nix
        ./modules/containers.nix
        ./modules/updates.nix
        ./modules/shell.nix
      ];
    };

    # The automated installer ISO
    nixosConfigurations.installer = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
        ./hosts/capybara/installer-iso.nix
      ];
    };
  };
}
