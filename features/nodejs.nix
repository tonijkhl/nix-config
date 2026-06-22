{ pkgs, ... }:

{
	# Always available packages
	home.packages = with pkgs; [
		nodejs_22
    		typescript-language-server
  	];

  	# Env var
  	home.sessionVariables = {
		# stops npm from rewriting nox global var
    		NODE_PATH = "$HOME/.npm-packages/lib/node_modules";
  	};

  	home.shellAliases = {
    		npm-local = "export PATH=\"$PWD/node_modules/.bin:$PATH\"";
  	};
}
