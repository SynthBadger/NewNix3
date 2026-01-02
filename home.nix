{ config, pkgs, lib, ... }:

{

  # -------------------------------
  # User info
  # -------------------------------
  home.username = "imogen";
  home.homeDirectory = "/home/imogen";
  home.stateVersion = "25.11";

  # -------------------------------
  # Packages
  # -------------------------------
  home.packages = with pkgs;  [

      alacritty
      fastfetch
      firefox
      fish
      git
      goverlay
      hunspell
      hunspellDicts.en_US
      hwinfo
      joplin
      kdePackages.kate
      neovim
      nh
      novelwriter
      putty
      qmk
      slack
      telegram-desktop
      tree
      vesktop
      via
      vim
      vlc
      xivlauncher-rb

   (writeShellScriptBin "acp" ''
    echo -n "Enter commit message: "
    read msg
    git add .
    git commit -m "$msg"
    git push
  '')

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
    initContent = ''
      PROMPT='%/ %#'
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
      takeoutdatrash = "sudo nix-channel --update; nix-env -u always; sudo nix-collect-garbage -d; rm -r /nix/var/nix/gcroots/auto*;";
    };
    history.size = 10000;
  };

}
