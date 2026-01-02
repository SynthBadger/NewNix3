{ config, pkgs, libs,  ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/printing.nix
      ../../modules/desktop.nix

    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "mem_sleep_default=s2idle" "nvidia-drm.fbdev=1"];
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings ={
    download-buffer-size = 1000000000;
  };

  networking.hostName = "desktop"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  hardware.uinput.enable = true;

  # Keybord settings

  hardware.keyboard.qmk.enable = true;
  services.udev.packages = with pkgs; [
    game-devices-udev-rules
    via
    ];

  users.users.imogen = {
    isNormalUser = true;
    description = "imogen";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "lp" "i2c" ]; # added i2c for OpenRGB
  };

    programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/nic/Projects/nixos-config";
  };

  hardware.graphics = {
      enable = true;
      #extraPackages = [pkgs.nvidia-vaapi-driver];
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  programs.gamemode.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };



   programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };


  environment.systemPackages = with pkgs; [

      winetricks
      wine
      vulkan-tools
      protonplus
      protonup-qt
      gamescope
      dxvk
      home-manager
      mangohud
      wayland-utils
      xivlauncher
      zsh
      gamemode

          (pkgs.xivlauncher-rb.override {
      useGameMode = true;
      useSteamRun = true;
      nvngxPath = "${config.hardware.nvidia.package}/lib/nvidia/wine";
    })

      ];

  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };



    services.hardware.openrgb.enable = true;
    services.hardware.openrgb.package = pkgs.openrgb-with-all-plugins;



    system.stateVersion = "25.05"; # Did you read the comment?

}
