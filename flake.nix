{
  inputs = {
    # Using the stable version
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For the unstable version, comment this out if not needed
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nixos-xivlauncher-rb = {
      url = "github:drakon64/nixos-xivlauncher-rb";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-xivlauncher-rb, ... }: {
    # NixOS configuration
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.imogen = import ./home.nix;
        }
        nixos-xivlauncher-rb.nixosModules.default
      ];
    };

    # Package definitions
    packages.x86_64-linux.niri = nixpkgs.lib.callPackage ./niri/default.nix { };

  };
}
