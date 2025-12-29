{ config, pkgs, ... }:

{
  xdg.portal = {
  enable = true;
  extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
  config.common.default = "kde";
};

  #################################
  ## Desktop (KDE Plasma 6)
  #################################
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.hardware.openrgb.enable = true;
  services.xserver.xkb.layout = "us";

  #################################
  ## Audio (PipeWire)
  #################################
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


}

