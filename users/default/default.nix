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
        imagemagick
        btop
        spotify
        feh
        vlc
        # These naughty apps are glorified web pages, use a browser instead.
        # discord
        # whatsapp-for-linux
        # telegram-desktop
        libreoffice
        slack
        appimage-run

        yubikey-manager
        protonvpn-cli_2
        bat
        fzf
        neofetch # I use ~Arch~ NixOS, btw
        ripgrep
        unzip # for the x alias to work
        pavucontrol
        jetbrains.goland
        jetbrains.pycharm-professional
      ]
      ++ (
        builtins.map
        (script: import script {inherit pkgs;})
        (lib.filesystem.listFilesRecursive ./scripts)
      );
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
    ];
  };

  home.file.".npmrc".source = ./data/.npmrc;

  home.sessionVariables = {
    EDITOR = "nvim";
    TERM = "alacritty";
    NIXPKGS_ALLOW_UNFREE = "1"; # Sins ahead.
  };
}
