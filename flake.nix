{
  description = "NixOS configuration for Imogen - 2025 Release";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.imogen = import ./home.nix;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }

        nixos-xivlauncher-rb.nixosModules.default
      ];
    };
  in {
    nixosConfigurations = {
      desktop = mkHost ./hosts/desktop/configuration.nix;
      laptop  = mkHost ./hosts/laptop/configuration.nix;
    };

    packages.x86_64-linux = {
      niri = nixpkgs.lib.callPackage ./niri/default.nix { };
    };
  };
}
