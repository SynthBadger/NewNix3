{ config, pkgs, ...}:

{
  # Stadia Controller Stuff

  hardware.uinput.enable = true;

  # Keybord settings

  hardware.keyboard.qmk.enable = true;
  services.udev.packages = with pkgs; [
    game-devices-udev-rules
    via
    ];
}
