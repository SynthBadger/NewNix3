{ config, pkgs, lib, ... }:

  let
  # This is the wrapper for the non-RB XIVLauncher
  xivlauncherWrapped = pkgs.writeShellScriptBin "xivlauncher" ''
    # Use Proton GE
    export WINE=${pkgs.steamProtonGE}/bin/wine64
    export WINEPREFIX=$HOME/.local/share/xivlauncher/wineprefix

    # DXVK + DLSS
    export DXVK_ENABLE_NVAPI=1       # required for DLSS
    export DXVK_PATH=${pkgs.dxvk}/lib/dxvk
    export VK_ICD_FILENAMES=${pkgs.vulkan-loader}/share/vulkan/icd.d/nvidia_icd.json
    export VK_LAYER_PATH=${pkgs.vulkan-loader}/share/vulkan/explicit_layer.d

    # Optional DLSS flags
    export DXVK_NVAPI_ENABLE=1
    export DXVK_USE_DLSS=1

    # Run the original launcher
    exec ${pkgs.xivlauncher}/bin/xivlauncher "$@"
  '';
in
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
