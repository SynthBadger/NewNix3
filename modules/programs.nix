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
      zsh
      fish
      home-manager
      wayland-utils
      alacritty
      nh
      slack
      tree     
      hwinfo


      (xivlauncher-rb.override {
        useGameMode = true;
        useSteamRun = true;
        nvngxPath = "${config.hardware.nvidia.package}/lib/nvidia/wine";
      })

  ];
        programs.firefox.enable = true;
        nixpkgs.config.allowUnfree = true;
        programs.zsh.enable = true;
        environment.shells = with pkgs; [
          zsh
        # fish
          ];


}
