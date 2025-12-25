{ config, pkgs, lib, ... }:

  let
    niri = import (fetchFromGitHub {
      owner = "sodiboo";
      repo = "system";
      rev = "main"; # or specify another revision if needed
      src = ./.;
    }) {};
  in {
    # Here you add your Home Manager configuration
    home.packages = [
      # Add any packages you want
    ];

    # Integrate the Niri module
    imports = [
      niri.personal.niri.mod.nix
    ];


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
   vlc
   neovim
   novelwriter
   hunspell
   hunspellDicts.en_US
   telegram-desktop
   fastfetch
   putty
   joplin
   vlc
   vesktop



    # add more packages here
  ];

  # -------------------------------
  # Dotfiles and custom files
  # -------------------------------
  home.file = {
    ".config/autostart/openrgb.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=OpenRGB
      Exec=${pkgs.openrgb}/bin/OpenRGB --minimized --startminimized --nogui
      X-GNOME-Autostart-enabled=true
    '';

    ".config/udev/rules.d/60-openrgb.rules".text = ''
      SUBSYSTEM=="usb", ATTR{idVendor}=="1b1c", MODE="0666"
      SUBSYSTEM=="usb", ATTR{idVendor}=="1209", MODE="0666"
    '';
  };

  # -------------------------------
  # Session variables
  # -------------------------------
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # -------------------------------
  # Home Manager itself
  # -------------------------------
  programs.home-manager.enable = true;



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
      update = "sudo nixos-rebuild switch --flake .";
      godot = "cd ~/.dotfiles";
      garbage = "nix-collect-garbage -d;";
      hmr = "home-manager switch --flake .";
      takeoutdatrash = "sudo nix-channel --update; sudo nix-env -u always; sudo nix-collect-garbage -d; sudo rm -r /nix/var/nix/gcroots/auto*;";
      upgrade = "sudo nixos-rebuild switch --upgrade";
    };
    history.size = 10000;
  };

}
