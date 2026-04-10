{ config, pkgs, ... }:

{
  users.users.advik = {
    isNormalUser = true;
    description = "Advik";
    extraGroups = [ "wheel" "docker" "networkmanager" ];
    shell = pkgs.nushell;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILW+fYDg8dBl4plpLl1CkQ9iHkx3BJi1l6V1XI4DV3n1"
    ];
  };

  # No root login, no password.
  users.mutableUsers = true;
}
