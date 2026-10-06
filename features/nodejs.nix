{ pkgs, ... }:

{
	# Always available packages
	home.packages = with pkgs; [
		nodejs_24
		pnpm_12
    		typescript-language-server
  	];

  	# Env var
  	home.sessionVariables = {
		# stops npm from rewriting nox global var
    		NODE_PATH = "$HOME/.npm-packages/lib/node_modules";

		# Ensures pnpm and npm global binaries are accessible in PATH
		PATH = "$HOME/.local/share/pnpm:$HOME/.npm-packages/bin:$PATH";
  	};

  	home.shellAliases = {
    		npm-local = "export PATH=\"$PWD/node_modules/.bin:$PATH\"";
  	};
}
