{ pkgs, ... }: {
  home.packages = with pkgs; [
# hyprpicker -- not mature enough
    hypridle
    wl-clipboard
    swww
  ];

  xdg.configFile."hypr/hypridle.conf".text = ''
    general {
      before_sleep_cmd = loginctl lock-session    # lock before suspend.
	after_sleep_cmd = ${pkgs.hyprland}/bin/hyprctl dispatch dpms on  # to avoid having to press a key twice to turn on the display.
    }

  listener {
    timeout = 150                                # 2.5min.
      on-timeout = ${pkgs.brightnessctl}/bin/brightnessctl -s set 10         # set monitor backlight to minimum, avoid 0 on OLED monitor.
      on-resume = ${pkgs.brightnessctl}/bin/brightnessctl -r                 # monitor backlight restore.
  }

  listener { 
    timeout = 150                                          # 2.5min.
      on-timeout = ${pkgs.brightnessctl}/bin/brightnessctl -sd rgb:kbd_backlight set 0 # turn off keyboard backlight.
      on-resume = ${pkgs.brightnessctl}/bin/brightnessctl -rd rgb:kbd_backlight        # turn on keyboard backlight.
  }

  listener {
    timeout = 300                                 # 5min
      on-timeout = loginctl lock-session            # lock screen when timeout has passed
  }

  listener {
    timeout = 330                                 # 5.5min
      on-timeout = ${pkgs.hyprland}/bin/hyprctl dispatch dpms off        # screen off when timeout has passed
      on-resume = ${pkgs.hyprland}/bin/hyprctl dispatch dpms on          # screen on when activity is detected after timeout has fired.
  }

  listener {
    timeout = 1800                                # 30min
      on-timeout = systemctl suspend                # suspend pc
  }
  '';

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
	"col.inactive_border" = "rgb(000000)";
	"col.active_border" = "rgb(ffffff)";

	layout = "dwindle";
	allow_tearing = false;
      };

      decoration.rounding = 0;
      decoration.drop_shadow = false;
      decoration.blur.enabled = false;

      animations.enabled = "no";

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
	  ", XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
	  ", XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l 2 @DEFAULT_AUDIO_SINK@ 5%+"
	  ", XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

	  ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
	  ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
	  ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
	  ];

      bindm = [
	"$mainMod, mouse:272, movewindow"
	  "$mainMod, mouse:273, resizewindow"
      ];

      exec-once = [
	"${pkgs.swww}/bin/swww-daemon"
	"${pkgs.swww}/bin/swww img ~/.config/wallpapers"
	"${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store"
	"${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store"
      ];

      windowrulev2 = [
	"noinitialfocus, class:^jetbrains-(?!toolbox),floating:1"
	"workspace 3, class:^(Spotify)$"
      ];
    };
  };
  services.cliphist.enable = true; 
	       }