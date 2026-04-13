{ config, lib, pkgs, ... }:

{
  systemd.network.enable = true;
  networking.useNetworkd = true;

  # Standard dhcp for the primary interface
  systemd.network.networks."10-ens18" = {
    matchConfig.Name = "ens18";
    networkConfig.DHCP = "yes";
  };

  # Tailscale
  services.tailscale.enable = true;

  # Mosh
  programs.mosh.enable = true;

  # Firewall settings
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
    allowedUDPPortRanges = [
      { from = 60000; to = 61000; } # Mosh
    ];
    trustedInterfaces = [ "tailscale0" ];
  };
}
