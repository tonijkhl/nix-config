{
	description = "Main toni's flake configuration";
	inputs= {
	nixpkgs.url = "nixpkgs/nixos-26.05";
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
				home-manager.nixosModules.home-manager {			
					nixpkgs.overlays = [ nix-openclaw.overlays.default ];
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.toni = import ./home.nix;
						backupFileExtension = "backup";
						extraSpecialArgs = { inherit inputs; };
					};
				}
			];
		};
	};

}
