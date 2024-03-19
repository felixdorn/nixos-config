# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
    ./hardware-configuration.nix
    ./nixos/impermanence
    ./nixos/sops-nix
    ./nixos/backup
    ./nixos/xserver
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; 

  virtualisation.docker.enable = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

# Configure console keymap
  console.keyMap = "fr";

  fonts.packages = with pkgs; [
    font-awesome
      powerline-fonts
      powerline-symbols
      (nerdfonts.override { fonts = [ "Hack" "NerdFontsSymbolsOnly" ]; })
  ];

  programs.zsh.enable = true;

  users.users.xilef = {
    home = "/home/xilef";
    createHome = true;
    isNormalUser = true;
    shell = pkgs.zsh;
    initialPassword = config.sops.secrets.pwd.path;
    extraGroups = [ "networkmanager" "wheel" "audio" "input" "docker" ];
  };

    users.users.rescue = {
    extraGroups = [ "networkmanager" "wheel" ];
     home = "/home/rescue";
        createHome = true;
        isNormalUser = true;
        shell = pkgs.zsh;
        initialPassword = "1234";
    };

  users.defaultUserShell = pkgs.zsh;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim 
      pulseaudio # for pactl
  ];


  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "xilef" = import ./home.nix;
    };
  };



  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.blueman.enable = true;

  services.gnome.gnome-keyring = {
    enable = true;
  };
  services.pcscd.enable = true;
  services.printing.enable = true;
  services.picom.enable = true;
  services.thermald.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      TLP_ENABLE = true;
    };
  };

  system.stateVersion = "23.11"; # Did you read the comment?
    system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc.automatic = true;
  nix.gc.dates = "20:00";
}

