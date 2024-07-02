args @ {
  pkgs,
  config,
  osConfig,
  inputs,
  lib,
  ...
}: {
  imports = lib.filesystem.listFilesRecursive ./modules;

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "default";
    homeDirectory = "/home/default";
    stateVersion = "23.11"; # Please read the comment before changing.
    packages = with pkgs;
      [
        openssl
        dua
        ungoogled-chromium
        tealdeer
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

  programs.rbw = {
    enable = true;
    settings = {
      email = "felixdorn@protonmail.com";
      base_url = "https://bitwarden.com";
    };
  };
  home.file.".npmrc".source = ./data/.npmrc;

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox-esr";
    TERM = "alacritty";
    NIXPKGS_ALLOW_UNFREE = "1"; # Sins ahead.
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["${pkgs.firefox-esr}/share/applications/firefox-esr.desktop"];
  };
}
