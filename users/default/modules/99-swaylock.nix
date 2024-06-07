{pkgs, ...}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      screenshots = true;
      clock = true;
      ignore-empty-password = true;
      show-failed-attempts = true;
      indicator = true;
      indicator-radius = 100;
      indicator-thickness = 7;
      effect-blur = "7x5";
      effect-vignette = "0.5:0.5";
      effect-greyscale = true;
      grace = 2;
      grace-no-mouse = true;
      grace-no-touch = true;

      ring-color = "#ffffff";
      key-hl-color = "#2563eb";
      line-color = "#2563eb";
      text-color = "#000000";
      inside-color = "#ffffff";
      separator-color = "#2563eb";
    };
  };
}
