{
  inputs = {
    # Using unstable for the whole system
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";


    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-xivlauncher-rb = {
      url = "github:drakon64/nixos-xivlauncher-rb";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-xivlauncher-rb, ... }: {
    # Changed name from 'desktop' to 'nixos' to match your configuration.nix
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
  };
}
