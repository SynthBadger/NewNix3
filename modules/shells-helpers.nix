{ config, pkgs, ...}:

{

programs.zsh.enable = true;
    users.extraUsers.imogen = {
    shell = pkgs.zsh;
    };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/nic/Projects/nixos-config";
  };


  environment.sessionVariables = {
        FLAKE = "/home/imogen/etc/nixos";
      };

      environment.shells = with pkgs; [
       zsh
      # fish

      ];

}
