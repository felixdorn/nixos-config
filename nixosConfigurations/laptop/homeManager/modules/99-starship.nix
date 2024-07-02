{ pkgs, ...}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile."starship.toml".source = ./../data/starship.toml;
}
