{ config, lib, pkgs, inputs, ... }:

{
	imports = [
		./hardware-configuration.nix
	];
 
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true; 

	networking.hostName = "nixos-gg";
	networking.networkmanager.enable = true;
	
	hardware.bluetooth.enable = true;
	services.power-profiles-daemon.enable = true;
	services.upower.enable = true;

	time.timeZone = "America/Panama";

	services.printing.enable = true;

	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		pulse.enable = true;
	};

	services.libinput.enable = true;

	users.users.toni= {
		isNormalUser = true;
		extraGroups = [ "wheel" "input" "video" ];
		packages = with pkgs; [
			tree
		];
	};

	nixpkgs.config.allowUnfree = true;

	programs.firefox.enable = true;

	environment.systemPackages = with pkgs; [
		# core tools
		vim
		git
		curl
		wget

		# terminal
		ghostty

		# desktop shell
		noctalia-shell
		xwayland-satellite
 	];

	# Electron based apps config
	environment.sessionVariables = {
		NIXOS_OZONE_WL = "1";
		ELECTRON_OZONE_PLATFORM_HINT = "auto";
	};

	environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

	programs.niri.enable = true;

	environment.etc."share/sddm/themes/noctalia-sddm".source = inputs.noctalia-sddm;

	# Configure sddm
	services.displayManager.sddm = {
		enable = true;
		wayland.enable = true;
		theme = "noctalia-sddm";
		package = pkgs.kdePackages.sddm;
	};

	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
	];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	system.stateVersion = "26.05";

}

