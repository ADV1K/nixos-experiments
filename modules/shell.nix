{ config, pkgs, ... }:

{
  # Shell setup
  programs.starship.enable = true;

  environment.systemPackages = with pkgs; [
    # Shell
    nushell
    starship
    zoxide
    
    # Core CLI
    git
    vim
    tmux
    htop
    btop
    ripgrep
    fd
    jq
    fzf
    eza
    uv
    direnv
    just
  ];

  # Global shell settings
  environment.variables = {
    EDITOR = "vim";
    SHELL = "${pkgs.nushell}/bin/nu";
  };
}
