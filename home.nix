{ pkgs, config, inputs, ... }:

{ 
  imports = [
      inputs.impermanence.nixosModules.home-manager.impermanence
      inputs.nixvim.homeManagerModules.nixvim
      ./home-manager/zsh
      ./home-manager/hyprland
      ./home-manager/firefox
      ./home-manager/git
      ./home-manager/waybar
      ./home-manager/starship
  ];

  nixpkgs.config.allowUnfree = true; # sins ahead
  nixpkgs.config.allowUnfreePredicate = _: true;       # Workaround for https://github.com/nix-community/home-manager/issues/2942

    home.username = "xilef";
  home.homeDirectory = "/home/xilef";
  home.stateVersion = "23.11"; # Please read the comment before changing.
    home.persistence."/persist/home-xilef" = {
      directories = [
	".mozilla/firefox"
      ];
      files = [ 
	".config/sops/age/keys.txt"
	".zsh_history"
      ];
      allowOther = true;
    };

  home.packages = with pkgs; [
# GUIs
    spotify
      discord
      insomnia
      zoom-us
      whatsapp-for-linux
      telegram-desktop
      libreoffice
      rofi
      obsidian
      pavucontrol # to manage sound (through waybar)
      dunst # notifications
      libnotify # notifications
      wbg # set a background image
      hyprpicker # (good) color picker
      pkgs.jetbrains.phpstorm
      pkgs.jetbrains.goland

# TUIs
btop
# Utilities
      yubikey-manager
      playerctl # for waybar
      bat # a cat alternative
      fzf # for fuzzy finding in mcfly, zoxide, or other
      wev # xev equivalent for wayland -- to debug which key is press
      neofetch # I use NixOS by the way
      ripgrep # better grep, used in nvim (telescope) and when grepping stuff
      fd # for neovim (telescope)
      wl-clipboard
      nix-prefetch-git # to get the sha256 hash of a git package
      unzip # for the 'x' alias to work with .zip
      ];



  qt.enable = true;
  qt.platformTheme = "gnome";
  qt.style.name = "adwaita-dark";
  qt.style.package = pkgs.adwaita-qt;

  gtk.enable = true;
  gtk.cursorTheme.package = pkgs.bibata-cursors;
  gtk.cursorTheme.name = "Bibata-Modern-Ice";

  gtk.theme.package = pkgs.adw-gtk3;
  gtk.theme.name = "adw-gtk3";




  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };


  programs.ssh = {
    enable = false;

    matchBlocks = {
      plane.hostname = "37.187.105.125";
      main.hostname = "54.38.192.161";
      side.hostname = "54.36.101.180";
    };
  };


  home.file.".npmrc".text = ''
    audit = false
    fund = false
    loglevel = error
    '';

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };


  programs.mcfly = {
    enable = true;
    fzf.enable = true;
    enableZshIntegration = true;
    keyScheme = "vim";
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  xdg.configFile = {
    "wallpaper.jpg".source = ./wallpaper.jpg;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERM = "alacritty";
  };

  services.cliphist.enable = true;
}
