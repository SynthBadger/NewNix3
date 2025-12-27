{ config, pkgs, ...}:

{

 # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = false;

  # Enable the KDE Plasma Desktop Environment.
  services.flatpak.enable = true;
  services.hardware.openrgb.enable = true;

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


}
