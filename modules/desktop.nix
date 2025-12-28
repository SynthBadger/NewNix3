{ config, pkgs, ...}:

{

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
    config.common.default = "kde";
  };



  services.xserver.enable = false;

  # Enable the KDE Plasma Desktop Environment.
  services.flatpak.enable = true;
  services.hardware.openrgb.enable = true;
  services.pipewire.wireplumber.enable = true;

  services.displayManager.sddm =
    {
      enable = true;
      wayland.enable = true;
    };

 services.desktopManager.plasma6.enable = true;


  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };


  services.pulseaudio.enable = false;
    security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true; # ensures compatibility with apps looking for PulseAudio
    jack.enable = true;
  };
  }
