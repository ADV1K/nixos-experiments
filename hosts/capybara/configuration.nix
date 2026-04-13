{ config, pkgs, ... }:

{
  networking.hostName = "capybara";

  # Proxmox specific settings
  services.qemuGuest.enable = true;

  # Use the GRUB legacy boot loader.
  boot.loader.grub.enable = true;

  # State version - Do not change
  system.stateVersion = "25.11";
}
