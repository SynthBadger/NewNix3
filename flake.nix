{
  inputs = {
    # Using unstable for the whole system
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-xivlauncher-rb = {
      url = "github:drakon64/nixos-xivlauncher-rb";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-xivlauncher-rb, ... }: {
    # Changed name from 'desktop' to 'nixos' to match your configuration.nix
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        nixos-xivlauncher-rb.nixosModules.default
      ];
    };
  };
}
