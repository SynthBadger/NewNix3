{ config, pkgs, libs,  ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/gaming.nix
      ../../modules/printing.nix
      ../../modules/desktop.nix
      ../../modules/peripherals.nix

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

  environment.systemPackages = with pkgs; [

      (xivlauncher-rb.override {
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
    services.openssh.enable = true;


    system.stateVersion = "25.05"; # Did you read the comment?

}
