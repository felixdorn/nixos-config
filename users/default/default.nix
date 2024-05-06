args @ {
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  imports =
    [
      inputs.sops-nix.homeManagerModules.sops
    ]
    ++ (lib.filesystem.listFilesRecursive ./modules);

  home = {
    username = "default";
    homeDirectory = "/home/default";
    stateVersion = "23.11"; # Please read the comment before changing.
    packages = with pkgs;
      [
        spotify
        prismlauncher
        # These naughty apps are glorified web pages, use a browser instead.
        # discord
        # whatsapp-for-linux
        # telegram-desktop
        libreoffice

        yubikey-manager
        bat
        fzf
        neofetch # I use ~Arch~ NixOS, btw
        ripgrep
        unzip # for the x alias to work
        wbg
        pavucontrol
        jetbrains.goland
      ]
      ++ (
        builtins.map
        (script: import script {inherit pkgs;})
        (lib.filesystem.listFilesRecursive ./scripts)
      );
  };

  home.file.".npmrc".source = ./data/.npmrc;

  home.sessionVariables = {
    EDITOR = "nvim";
    TERM = "alacritty";
    NIXPKGS_ALLOW_UNFREE = "1"; # Sins ahead.
  };
}
