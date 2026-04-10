{ config, lib, pkgs, ... }:

{
  # Automatic updates (Monthly cycle)
  system.autoUpgrade = {
    enable = true;
    flake = "github:advik/nixos-config#capybara"; # Placeholder, update with your repo
    dates = "monthly"; # Effectively a 1-month threshold for major updates
    allowReboot = true;
  };

  # Lightweight monitoring
  services.prometheus.exporters.node = {
    enable = true;
    enabledCollectors = [ "systemd" ];
    port = 9100;
  };

  # Only expose node-exporter to Tailscale
  networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 9100 ];

  # Cleanup old generations
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
}
