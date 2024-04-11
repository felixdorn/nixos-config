{ pkgs, ... }: {
  qt = {
    enable = true;
    platformTheme = "gnome";
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt;
  };

  gtk = {
    enable = true;
    platformTheme = "gnome";

    theme.name = "adw-gtk3";
    theme.package = pkgs.adw-gtk3;

    cursorTheme.name = "Bibata-Modern-Ice";
    cursorTheme.package = pkgs.bibata-cursors;
  };
}
