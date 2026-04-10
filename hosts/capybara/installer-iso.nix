{ config, pkgs, lib, inputs, ... }:

{
  # Minimal ISO base
  isoImage.isoName = lib.mkForce "nixos-installer-capybara.iso";
  isoImage.makeEfiBootable = true;
  isoImage.makeUsbBootable = true;

  # Network
  networking.hostName = "installer";
  services.tailscale.enable = false;

  # Self-installing service
  systemd.services.install-capybara = {
    description = "Automated NixOS Installation";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    
    serviceConfig = {
      Type = "oneshot";
      StandardOutput = "journal+console";
      StandardError = "journal+console";
    };

    path = with pkgs; [ 
      git 
      nixos-install-tools 
      disko 
      curl 
      util-linux 
      gptfdisk
      btrfs-progs
    ];

    script = ''
      set -euxo pipefail

      echo "Waiting for internet..."
      until curl -s google.com > /dev/null; do sleep 5; done

      echo "Partitioning disk..."
      # Use Disko to partition /dev/vda
      # Note: We use the local disko.nix from the flake
      nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ${./disko.nix}

      echo "Installing NixOS..."
      # Install using the flake configuration directly
      # Replace 'github:advik/nixos-config' with your actual repository if external
      # For this local build, we can bundle the flake or use the current path
      nixos-install --no-root-passwd --flake "/iso/nixos#capybara"

      echo "Installation complete. Rebooting in 10 seconds..."
      sleep 10
      reboot
    '';
  };

  # Embed the configuration into the ISO for offline-capable (mostly) install
  system.activationScripts.copy-flake = {
    text = ''
      mkdir -p /iso/nixos
      cp -r ${../../.}/* /iso/nixos/
    '';
  };

  # Disable confirmation
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}
