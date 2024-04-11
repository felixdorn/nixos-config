{ pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      env = [
	"XCURSOR_SIZE,24"
	  "QT_QPA_PLATFORMTHEME,qt5ct"
      ];


      input = {
	kb_layout = "fr";
	kb_variant = "";
	kb_model = "";
	kb_options = "";
	kb_rules = "";

	follow_mouse = 1;

	touchpad = {
	  natural_scroll = "no";
	};

	sensitivity = 0;
      };

      general = {
	gaps_in = 5;
	gaps_out = 10;
	border_size = 2;
	"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
	"col.inactive_border" = "rgba(595959aa)";

	layout = "dwindle";
	allow_tearing = false;
      };

      decoration = {
	rounding = 5;

	drop_shadow = false;
      };

      animations = {
	enabled = "yes";

	bezier = [ "main, 0.05, 0.9, 0.1, 1.05" ];

	animation = [
	  "windows, 1, 7, main"
	    "windowsOut, 1, 7, default, popin 80%"
	    "border, 1, 10, default"
	    "borderangle, 1, 8, default"
	    "fade, 1, 7, default"
	    "workspaces, 1, 6, default"
	];
      };

      dwindle = {
	pseudotile = "yes";
	preserve_split = "yes";
      };

      master = {
	new_is_master = true;
      };

      gestures = {
	workspace_swipe = false;
      };

      misc = {
	force_default_wallpaper = 0;
	vfr = true;
      };

      "$mainMod" = "SUPER";

      bind = [
	"$mainMod, Return, exec, ${pkgs.alacritty}/bin/alacritty"
	  "$mainMod, Q, killactive"
	  "$mainMod SHIFT, Q, exit"
	  "$mainMod, E, togglesplit"
	  "$mainMod, D, exec, ${pkgs.rofi-wayland}/bin/rofi -show drun"
	  "$mainMod, V, togglefloating"
	  "$mainMod, F, fullscreen"
	  "$mainMod, P, pseudo"

# Move focus with mainMod + arrow keys
	  "$mainMod, left, movefocus, l"
	  "$mainMod, right, movefocus, r"
	  "$mainMod, up, movefocus, u"
	  "$mainMod, down, movefocus, d"

# Move active window to a workspace with mainMood + SHIFT + "[0-9]"
	  "$mainMod, ampersand, workspace, 1"
	  "$mainMod, eacute, workspace, 2"
	  "$mainMod, quotedbl, workspace, 3"
	  "$mainMod, apostrophe, workspace, 4"
	  "$mainMod, parenleft, workspace, 5"
	  "$mainMod, minus, workspace, 6"
	  "$mainMod, egrave, workspace, 7"
	  "$mainMod, underscore, workspace, 8"
	  "$mainMod, ccedilla, workspace, 9"
	  "$mainMod, agrave, workspace, 10"

# Move active window to a workspace with mainMod + SHIFT + [0-9]
	  "$mainMod SHIFT, ampersand, movetoworkspacesilent, 1"
	  "$mainMod SHIFT, eacute, movetoworkspacesilent, 2"
	  "$mainMod SHIFT, quotedbl, movetoworkspacesilent, 3"
	  "$mainMod SHIFT, apostrophe, movetoworkspacesilent, 4"
	  "$mainMod SHIFT, parenleft, movetoworkspacesilent, 5"
	  "$mainMod SHIFT, minus, movetoworkspacesilent, 6"
	  "$mainMod SHIFT, egrave, movetoworkspacesilent, 7"
	  "$mainMod SHIFT, underscore, movetoworkspacesilent, 8"
	  "$mainMod SHIFT, ccedilla, movetoworkspacesilent, 9"
	  "$mainMod SHIFT, agrave, movetoworkspacesilent, 10"

# Bind functions key to their respective function
	  ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
	  ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ 5%+"
	  ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

	  ", XF86AudioPlay, exec, playerctl play-pause"
	  ", XF86AudioNext, exec, playerctl next"
	  ", XF86AudioPrev, exec, playerctl previous"

# Clipboard manager binds
	  "SUPER SHIFT, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
	  ];

      bindm = [
	"$mainMod, mouse:272, movewindow"
	  "$mainMod, mouse:273, resizewindow"
      ];

      exec-once = [
        "eval $(gnome-keyring-daemon --start --components pkcs11,secrets,ssh)"
        "wbg ~/.config/wallpaper.jpg"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      windowrulev2 = [
	"noinitialfocus, class:^jetbrains-(?!toolbox),floating:1"
      "workspace 3, class:^(Spotify)$"
      ];
    };
  };
}
