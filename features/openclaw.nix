{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nix-openclaw.homeManagerModules.default
  ];

  programs.openclaw = {
    enable = true;
    workspace = {
      bootstrapFiles = {
        agents = ./openclaw-workspace/AGENTS.md;
        soul = ./openclaw-workspace/SOUL.md;
        tools = ./openclaw-workspace/TOOLS.md;
        identity = ./openclaw-workspace/IDENTITY.md;
        user = ./openclaw-workspace/USER.md;
      };
    };

    # Essential runtime binaries for your agent CLI toolkit
    runtimePackages = with pkgs; [
      git
      jq
      ripgrep
      gh
    ];
  };
}
