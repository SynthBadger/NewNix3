{ config, pkgs, ...}:

{

xdg.portal = {
  enable = true;
  
 config = {
        common = {
          default = "wlr";
        };
      };
      wlr.enable = true;
      wlr.settings.screencast = {
        output_name = "<DP-2>";
        chooser_type = "simple";
        chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
      }; 

 # config.common.default = "kde";  # only KDE portal
 # extraPortals = with pkgs; [ kdePackages.xdg-desktop-portal-kde ];
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
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;

      };
}
