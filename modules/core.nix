{ config, pkgs, ... }:

{
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";

  # Nix configuration
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "@wheel" ];
  };

  # SSH configuration
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  # SSH hardening: fail2ban
  services.fail2ban.enable = true;
}
