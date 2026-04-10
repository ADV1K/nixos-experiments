{ config, pkgs, ... }:

{
  networking.hostName = "capybara";

  # Proxmox specific settings
  services.qemuGuest.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # State version - Do not change
  system.stateVersion = "25.11";
}
