{ config, pkgs, ...}:

{


  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/nic/Projects/nixos-config";
  };


  environment.sessionVariables = {
        FLAKE = "/home/imogen/etc/nixos";
      };



}
