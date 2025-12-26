{
  description = "NixOS configuration for Imogen - 2025 Release";

  inputs = {
    # NixOS 25.11 "Xantusia" is the stable release as of late 2025
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

  outputs = { self, nixpkgs, home-manager, nixos-xivlauncher-rb, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # Pass 'inputs' to all modules so they can reference other flakes
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.imogen = import ./home.nix;
          # Also pass 'inputs' to Home Manager specifically
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
        nixos-xivlauncher-rb.nixosModules.default
      ];
    };

    # Package definitions (exposed for 'nix build' or 'nh search')
    packages.x86_64-linux = {
      niri = nixpkgs.lib.callPackage ./niri/default.nix { };
    };
  };
}
