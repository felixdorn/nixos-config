{
  pkgs,
  config,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      shell = {
        program = "${config.programs.zsh.package}/bin/zsh";
        args = ["--login"];
      };

      # home.sessionVariables allows integers, booleans, etc.
      # and programs.alacritty.env accepts only strings
      env = builtins.mapAttrs (name: value: builtins.toString value) config.home.sessionVariables;

      window = {
        padding = {
          y = 0;
          x = 0;
        };

        opacity = 1;
      };

      font = rec {
        size = 11;

        normal.family = "Jetbrains Mono";
        bold.family = normal.family;
        italic.family = normal.family;
      };

      mouse = {
        hide_when_typing = true;
      };
    };
  };
}
