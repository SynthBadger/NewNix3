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
   vim
   openrgb-with-all-plugins
   neovim
   novelwriter
   hunspell
   hunspellDicts.en_US
   telegram-desktop
   fastfetch
   putty
   joplin
   vlc
   discord




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
      lapup = "sudo nixos-rebuild switch --flake .#laptop";
      dskup = "sudo nixos-rebuild switch --flake .#desktop";
      qwe = "cd /etc/nixos";
      garbage = "nh clean all --keep 2 --dry";
      hmr = "sudo home-manager switch --flake .";
      # takeoutdatrash = "sudo nix-channel --update; nix-env -u always; sudo nix-collect-garbage -d; rm -r /nix/var/nix/gcroots/auto*;"; 
    };
    history.size = 10000;
  };

}
