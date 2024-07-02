{ pkgs, ... }: {
  qt = {
    enable = true;
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";
    size = 16;
  };

  gtk = {
    enable = true;
    theme.name = "adw-gtk3";
    theme.package = pkgs.adw-gtk3;
  };
}
