{ pkgs, ...}: {
 services.xserver = {
    enable = true;

    xkb = {
      layout = "fr";
    };
  };
  services.xserver.displayManager.sddm = {
    enable = true;
    theme = "${import ./sddm-theme.nix { inherit pkgs; }}";

    wayland.enable = true;
  };
}