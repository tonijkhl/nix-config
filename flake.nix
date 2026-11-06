{
  description = "Main toni's flake configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-sddm = {
      url = "github:mahaveergurjar/sddm?ref=noctalia";
      flake = false;
    };

    nix-openclaw.url = "github:openclaw/nix-openclaw";
  };

  outputs = { self, nixpkgs, home-manager, nix-openclaw, ... }@inputs: {
    nixosConfigurations.nixos-gg = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix

        # openclaw overlay and config globally at the system level
        {
          nixpkgs.overlays = [ nix-openclaw.overlays.default ];
          nixpkgs.config.permittedInsecurePackages = [
            # Add any insecure package identifiers here if flagged during builds
          ];
        }

        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.toni = import ./home.nix;
            backupFileExtension = "backup";
            extraSpecialArgs = {
              inherit inputs;
              pkgs-unstable = import inputs.nixpkgs-unstable {
                system = "x86_64-linux";
                config.allowUnfree = true;
              };
            };
          };
        }
      ];
    };
  };
}
