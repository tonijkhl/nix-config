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
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;

		# force jack
		wireplumber.enable = true;
	};

	# TTL packets number change
	boot.kernel.sysctl = {
		"net.ipv4.ip_default_ttl" = 65;
		# IPv6
		"net.ipv6.conf.all.hoop_limit" = 65;
		"net.ipv6.conf.default.hoop_limit" = 65;
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

		# cursor
		adwaita-icon-theme

		# sddm dependencies
		kdePackages.qt5compat
		kdePackages.qtdeclarative
		kdePackages.qtsvg

		# phone webcam
		scrcpy
		droidcam
		android-tools

		# network-tools
		iw
		aircrack-ng
		wpa_supplicant
		python3
		pixiewps
		python313Packages.wcwidth
 	];

	#phone webcam
	boot.kernelModules = [ "v4l2loopback" ];
	boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
  	boot.extraModprobeConfig = ''
    		options v4l2loopback devices=1 exclusive_caps=1 card_label="DroidCam" video_nr=9 max_width=1920 max_height=1080
	'';

	programs.nix-ld.enable = true;

	environment.sessionVariables = {
		# Electron based apps config
		NIXOS_OZONE_WL = "1";
		ELECTRON_OZONE_PLATFORM_HINT = "auto";

		# cursor variables
		XCURSOR_THEME = "Adwaita";
		XCURSOR_SIZE = "24";
	};

	environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

	programs.niri.enable = true;

	# sddm Configuration
	# environment.etc."share/sddm/themes/noctalia-sddm".source = inputs.noctalia-sddm;

	services.displayManager.sddm = {
		enable = true;
		wayland.enable = true;
		wayland.compositor = "kwin";

		# theme = "noctalia-sddm";
		
		package = pkgs.kdePackages.sddm;

		settings = {
			Theme = {
				CursorTheme = "Adwaita";  
			};
		};


		theme = "${pkgs.runCommand "noctalia-sddm" {} ''
			mkdir -p $out/share/sddm/themes
			cp -r ${inputs.noctalia-sddm} $out/share/sddm/themes/noctalia-sddm
		''}";
	};

	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
	];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	system.stateVersion = "26.05";

}

