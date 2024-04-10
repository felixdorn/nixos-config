{ pkgs, ...}: {
  programs.mcfly = {
    enable = true;
    fzf.enable = true;
    enableZshIntegration = true;
    keyScheme = "vim";
  };
}
