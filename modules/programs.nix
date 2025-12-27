{ config, pkgs, ...}:
 {
  environment.systemPackages = with pkgs; [
      git
      protonplus
      dxvk
      wine
      winetricks
      vulkan-tools
      gamescope
      goverlay
      mangohud
      via
      qmk
      via
      qmk
      zsh
      fish
      home-manager
      wayland-utils
      alacritty
      nh
      slack
      tree     
      hwinfo
      #xwayland-satellite-unstable


      #XivLauncher Setup
      (xivlauncher-rb.override {
        useGameMode = true;
        useSteamRun = true;
        nvngxPath = "${config.hardware.nvidia.package}/lib/nvidia/wine";
      })

  ];

}
