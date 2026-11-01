{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nix-openclaw.homeManagerModules.openclaw
  ];

  programs.openclaw = {
    enable = true;

    tools = [
      "git"
      "github"
      "filesystem"
    ];


    workspace = {
      bootstrapFiles = {
        agents = ./openclaw-workspace/AGENTS.md;
        soul = ./openclaw-workspace/SOUL.md;
        tools = ./openclaw-workspace/TOOLS.md;
        identity = ./openclaw-workspace/IDENTITY.md;
        user = ./openclaw-workspace/USER.md;
      };
    };

    runtimePackages = with pkgs; [
      git
      jq
      ripgrep
      gh
    ];
  };
}
