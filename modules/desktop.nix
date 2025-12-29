{ config, pkgs, ... }:

{
  # 1. Essential Desktop Services
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Keep xserver enabled for XWayland and keyboard support
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  ## 2. XDG Portals (Critical for Screen Sharing)
  #xdg.portal = {
  #  enable = true;
  #  extraPortals = [
  #    pkgs.kdePackages.xdg-desktop-portal-kde # Correct attribute for Plasma 6
  # #   pkgs.xdg-desktop-portal-gtk
  #  ];
  #  config.common.default = "kde";
  #};


  # 3. Audio & PipeWire (Best Practice 2025)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };



  # 5. you need this for vesktop to work
  environment.sessionVariables = {
  NIXOS_OZONE_WL = "1";
  };
}

