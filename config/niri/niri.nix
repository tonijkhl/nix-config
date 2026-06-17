{ config, pkgs, inputs, ... }: {
  imports = [
    inputs.niri.homeModules.niri
  ];

  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-unstable; 

  programs.niri.settings.cursor = {
    theme = "Bibata-Rainbow-Modern";
    size = 24;
  };

  programs.niri.config = ''
    spawn-at-startup "noctalia-shell"

    layout {
      gaps 8

      border {
	off 
      }

      focus-ring {
	width 2
	active-color "#fff2cc"
        inactive-color "#3c3836"
      }
    }

    window-rule {
    	match app-id="com.mitchellh.ghostty"
	background-effect {
		blur false
	}

	focus-ring {
		off
	}

	border {
		off
	}

      geometry-corner-radius 8
      clip-to-geometry true
    }

    binds {
      "Mod+T"         { spawn "ghostty"; }
      "Mod+D"         { spawn "noctalia-shell" "ipc" "call" "launcher" "toggle"; }
      "Mod+M"         { spawn "noctalia-shell" "ipc" "call" "lockScreen" "lock"; }
      "Mod+X"         { spawn "noctalia-shell" "ipc" "call" "controlCenter" "toggle"; }

      "Mod+Q"         { close-window; }

      "Mod+H"         { focus-column-left; }
      "Mod+L"         { focus-column-right; }
      "Mod+J"         { focus-window-down; }
      "Mod+K"         { focus-window-up; }

      "Mod+Left"      { focus-column-left; }
      "Mod+Right"     { focus-column-right; }
      "Mod+Down"      { focus-window-down; }
      "Mod+Up"        { focus-window-up; }

      "Mod+Ctrl+H"    { move-column-left; }
      "Mod+Ctrl+L"    { move-column-right; }
      "Mod+Ctrl+J"    { move-window-down; }
      "Mod+Ctrl+K"    { move-window-up; }

      "Mod+Ctrl+Left"  { move-column-left; }
      "Mod+Ctrl+Right" { move-column-right; }
      "Mod+Ctrl+Down"  { move-window-down; }
      "Mod+Ctrl+Up"    { move-window-up; }

      "Mod+1" { focus-workspace 1; }
      "Mod+2" { focus-workspace 2; }
      "Mod+3" { focus-workspace 3; }
      "Mod+4" { focus-workspace 4; }
      "Mod+5" { focus-workspace 5; }
      "Mod+6" { focus-workspace 6; }
      "Mod+7" { focus-workspace 7; }
      "Mod+8" { focus-workspace 8; }
      "Mod+9" { focus-workspace 9; }

      "Mod+Ctrl+1" { move-window-to-workspace 1; }
      "Mod+Ctrl+2" { move-window-to-workspace 2; }
      "Mod+Ctrl+3" { move-window-to-workspace 3; }
      "Mod+Ctrl+4" { move-window-to-workspace 4; }
      "Mod+Ctrl+5" { move-window-to-workspace 5; }
      "Mod+Ctrl+6" { move-window-to-workspace 6; }
      "Mod+Ctrl+7" { move-window-to-workspace 7; }
      "Mod+Ctrl+8" { move-window-to-workspace 8; }
      "Mod+Ctrl+9" { move-window-to-workspace 9; }

      "Mod+F"           { maximize-column; }
      "Mod+Shift+F"     { fullscreen-window; }
      "Mod+C"           { center-column; }
      "Mod+Minus"       { set-column-width "-10%"; }
      "Mod+Equal"       { set-column-width "+10%"; }
      "Mod+Shift+Minus" { set-window-height "-10%"; }
      "Mod+Shift+Equal" { set-window-height "+10%"; }

      "Mod+BracketLeft"  { consume-or-expel-window-left; }
      "Mod+BracketRight" { consume-or-expel-window-right; }
      "Mod+Comma"        { consume-window-into-column; }
      "Mod+Period"       { expel-window-from-column; }

      "Mod+R"      { switch-preset-column-width; }
      "Mod+Ctrl+F" { expand-column-to-available-width; }

      "Mod+O"            { toggle-overview; }
      "Mod+Shift+Escape" { show-hotkey-overlay; }

      "Print"      { screenshot show-pointer=false; }
      "Ctrl+Print" { screenshot-screen show-pointer=false; }
      "Alt+Print"  { screenshot-window write-to-disk=false; }
    }


  '';
}
