{ pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;

    input.kb_layout = "fr";

    bind = [
      "$mainMod, Return, exec, ${pkgs.alacritty}/bin/alacritty"
    ];

    settings = {};
  };
}
