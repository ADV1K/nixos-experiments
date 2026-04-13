{ config, pkgs, ... }:

{
  users.users.advik = {
    isNormalUser = true;
    description = "Advik";
    extraGroups = [ "wheel" "docker" "networkmanager" ];
    shell = pkgs.nushell;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPfBhL4psTGBlo+emwtTPdaySzaoScsbiKl4Z1tx1SXF"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMc4CmyjdX1qaResQVgFLipk2hK1YiUpCI1dJROIoHEP"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMV6lTfN9wnRCQEMrRmBRGMN6uRXQv+tCYU33KXeVTXW"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOyg+AejaQa5XoFMJnvWaQMmGR2YH9U3v1Tgw0oSQU6c"
    ];
  };

  # No root login, no password.
  users.mutableUsers = true;
}
