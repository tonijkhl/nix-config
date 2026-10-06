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

			credential."https://github.com".helper = "${pkgs.gh}/bin/gh auth git-credential";
			credential."https://gist.github.com".helper = "${pkgs.gh}/bin/gh auth git-credential";
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

		# initialize starship on startup
		initExtra = ''
      			eval "$(starship init bash)"
    		'';

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
		qbittorrent
		vlc

		# audio interface
		guitarix
		crosspipe
		pipewire
		pipewire.jack

		# office suite
		onlyoffice-desktopeditors

		# CLI & Shell
		tmux
		gh
		yazi
		starship

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
