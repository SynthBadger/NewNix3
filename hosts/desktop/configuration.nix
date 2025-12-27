

{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/programs.nix
      ../../modules/audio.nix
      ../../modules/gaming.nix
      ../../modules/printing.nix
      ../../modules/desktop.nix
      ../../modules/peripherals.nix

    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.modeset.force-atomic=1"
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings ={
    download-buffer-size = 1000000000;
  };
  networking.hostName = "nixos"; # Define your hostname.
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
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
      thunderbird
    ];
  };


  programs.firefox.enable = true;
  programs.niri.enable = false;

  nixpkgs.config.allowUnfree = true;

  hardware.graphics.enable = true;

  #Screen Sharing Stuff.
  xdg.portal = {
    enable = true;
    config.common.default = "kde";  # Force KDE portal only
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
  };





    programs.zsh.enable = true;
    users.extraUsers.imogen = {
    shell = pkgs.zsh;
    };
    environment.shells = with pkgs; [
       zsh
     # fish
       ];

  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

    services.openssh.enable = true;
    system.stateVersion = "25.05"; # Did you read the comment?

}
