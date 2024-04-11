{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = { y = 5; x = 5; };

	opacity = 1;
      };

      font = rec {
        size = 12;

	normal.family = "Hack Nerd Font";
	bold.family = normal.family;
	italic.family = normal.family;
      };
    };
  };
}
