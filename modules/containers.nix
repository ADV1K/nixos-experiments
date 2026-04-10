{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;

  # Additional container tools
  environment.systemPackages = with pkgs; [
    kind
    runc
    docker-compose
  ];
}
