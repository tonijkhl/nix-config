{ config, pkgs, ... }:

{
	imports = [
		./features/nodejs.nix
	];

	home.username = "toni";
	home.homeDirectory = "/home/toni";
	home.stateVersion = "26.05";

	programs.git = {
		enable = true;
		userName = "toni";
		userEmail = "tonilopez0199@gmail.com";
		
		settings = {
			pull.rebase = true;
			core.editor = "vim";
		};
		
		ignores = [
			"*.swp"
		];
	};

	programs.bash = {
		enable = true;

		sessionVariables = {
			EDITOR = "vim";
			VISUAL = "vim";
		};

		shellAliases = {
			contrl = "echo test dotfiles config comes here";
		};

	};


	home.packages = with pkgs; [
		brave
		obsidian
		rclone
		proton-authenticator
		thunderbird
		pixieditor
		chafa

		tmux
	
		gh
		yazi

		neovim
		gcc
		gnumake
		unzip
		ripgrep
		fd
	];

	home.pointerCursor = {
		package = pkgs.bibata-cursors;
		name = "Bibata-Rainbow-Modern";
		size = 24;
		gtk.enable = true;
		x11.enable = true;
	};

}
