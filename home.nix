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

		# audio interface
		guitarix
		crosspipe
		pipewire
		pipewire.jack

		# office suite
		onlyoffice-desktopeditors

		tmux	
		gh
		yazi

		# neovim
		neovim
		gcc
		gnumake
		unzip
		ripgrep
		fd

		# PDF, CBZ, DJVU viewer
		( zathura.override {
      			plugins = with zathuraPkgs; [
        			zathura_pdf_mupdf
        			zathura_djvu
        			zathura_cb
      			];
    		})
	];

	home.pointerCursor = {
		package = pkgs.bibata-cursors;
		name = "Bibata-Rainbow-Modern";
		size = 24;
		gtk.enable = true;
		x11.enable = true;
	};

}
