{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtsvg
  ];

  services.xserver.displayManager.sddm = { 
    enable = true;
    autoNumlock = true;
    theme = "${import ./../packages/sddm-sugar-dark.nix { inherit pkgs; }}"; 
    wayland.enable = true;
  };
}
