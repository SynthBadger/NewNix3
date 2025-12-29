{ config, pkgs, lib, ... }:

{

  # -------------------------------
  # User info
  # -------------------------------
  home.username = "imogen";
  home.homeDirectory = "/home/imogen";
  home.stateVersion = "25.05";

  # -------------------------------
  # Packages
  # -------------------------------
  home.packages = with pkgs;  [
   vim
   openrgb
   neovim
   novelwriter
   hunspell
   hunspellDicts.en_US
   telegram-desktop
   fastfetch
   putty
   joplin
   vlc

  ];

  # -------------------------------
  # Dotfiles and custom files
  # -------------------------------
  home.file = {};

  # -------------------------------
  # Session variables
  # -------------------------------
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # -------------------------------
  # Home Manager itself
  # -------------------------------
  #programs.home-manager.enable = true;

  programs.vesktop = {
  enable = true;
  vencord.settings = {
    useQuickCss = true;
    plugins.Settings.enabled = true; # Ensures the settings menu itself is enabled
  };
};

  # -------------------------------
  # Zsh configuration
  # -------------------------------
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      PROMPT='%/ %#'
    '';
    shellAliases = {
      ll = "ls -l";
      bigp = "git pull origin master --force";
      lapup = "sudo nixos-rebuild switch --flake .#laptop";
      dskup = "sudo nixos-rebuild switch --flake .#desktop";
      qwe = "cd /etc/nixos";
      garbage = "nh clean all --keep 2";
      dskrb = "sudo nixos-rebuild switch --recreate-lock-file --flake .#desktop";
      laprb = "sudo nixos-rebuild switch --recreate-lock-file --flake .#laptop";
      # takeoutdatrash = "sudo nix-channel --update; nix-env -u always; sudo nix-collect-garbage -d; rm -r /nix/var/nix/gcroots/auto*;";
    };
    history.size = 10000;
  };

}
