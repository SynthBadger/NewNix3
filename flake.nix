{
  description = "NixOS configuration for Imogen - 2025 Release";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 1. Add the XIVLauncher-RB input
    nixos-xivlauncher-rb = {
      url = "github:drakon64/nixos-xivlauncher-rb";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-xivlauncher-rb, ... }@inputs:
    let
      system = "x86_64-linux";
      mkHost = hostPath: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          hostPath
          home-manager.nixosModules.home-manager
          # 2. Add the XIVLauncher-RB NixOS module here
          nixos-xivlauncher-rb.nixosModules.default
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.imogen = import ./home.nix;
              extraSpecialArgs = { inherit inputs; };
            };
          }
        ];
      };
    in {
      nixosConfigurations = {
        desktop = mkHost ./hosts/desktop/configuration.nix;
        laptop = mkHost ./hosts/laptop/configuration.nix;
      };
    };
}
