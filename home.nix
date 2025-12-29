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
   kdePackages.kate
   xwayland
   vesktop
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

  # -------------------------------
  # Zsh configuration
  # -------------------------------
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Using initExtra instead of initContent for better compatibility
    initContent = ''
      PROMPT='%/ %#'

      # Standard Zsh function definition
      gacp() {
        # Note: Zsh uses "read 'VAR?Prompt: '" syntax
        read "MSG?Enter commit message: "
        git add .
        git commit -m "$MSG"
        git push
      }
    '';

    shellAliases = {
      ll = "ls -l";
      bigp = "git pull origin master --force";
      lapup = "nh os switch --update . -H laptop";
      dskup = "nh os switch --update . -H desktop";
      qwe = "cd /etc/nixos";
      garbage = "nh clean all --keep 2";
      dskrb = "sudo nixos-rebuild switch --recreate-lock-file --flake .#desktop";
      laprb = "sudo nixos-rebuild switch --recreate-lock-file --flake .#laptop";

      # takeoutdatrash = "sudo nix-channel --update; nix-env -u always; sudo nix-collect-garbage -d; rm -r /nix/var/nix/gcroots/auto*;";
    };
    history.size = 10000;
  };

}
