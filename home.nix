{ config, pkgs, ... }:

{
	imports = [
		./config/niri/niri.nix
	];

	home.username = "toni";
	home.homeDirectory = "/home/toni";
	home.stateVersion = "26.05";

	programs.git = {
		enable = true;
		userName = "toni";
		userEmail = "tonilopez0199@gmail.com";
		
		extraConfig = {
			pull.rebase = true;
			core.editor = "vim";
		};
		
		ignores = [
			"*.swp"
		];
	};

	programs.bash = {
		enable = true;
		shellAliases = {
			contrl = "echo test dotfiles config comes here";
		};

	};


	home.packages = with pkgs; [
		brave
		obsidian
		rclone
		proton-authenticator
		
		gh
		yazi
		neovim
		gcc
	];
	
	home.pointerCursor = {
		package = pkgs.bibata-cursors;
		name = "Bibata-Rainbow-Modern";
		size = 24;
		gtk.enable = true;
		x11.enable = true;
	};

	systemd.user.services.noctalia-lock-on-start = {
		Unit = {
			Description = "Lock screen on session start";
			After = [ "graphical-session.target" ];
		};
		Service = {
			Type = "oneshot";
			ExecStart = "${pkgs.bash}/bin/sh -c 'sleep 5 && ${pkgs.noctalia-shell}/bin/noctalia-shell ipc call lockScreen lock'";
			Environment = "WAYLAND_DISPLAY=wayland-1";
  		};
		Install.WantedBy = [ "graphical-session.target" ];
	};
}
