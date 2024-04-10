# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

args @ { inputs, config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./os/secrets.nix	
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-26ff45a1-116c-4196-80ec-0cb8c595c5d6".device = "/dev/disk/by-uuid/26ff45a1-116c-4196-80ec-0cb8c595c5d6";
  
  # Networking
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Locale
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

  # X11
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Keyboard
  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };
  console.keyMap = "fr";

  # Printing
  services.printing.enable = true;

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
 };

  # Users
  users.users.default = {
    home = "/home/default";
    createHome = true;
    isNormalUser = true;

    description = "Félix Dorn";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Home Manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = let common = {
      nixpkgs.config.allowUnfree = true;
    }; in builtins.listToAttrs (map 
      (user: { 
          name = user;
	  value = ((import ./users/${user}) args) // common;
      })
      (
        builtins.filter 
	  (user: config.users.users.${user}.isNormalUser)
	  (builtins.attrNames config.users.users)
      )
    );
  };

  # Automatic login
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "default";
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # System
  environment.systemPackages = with pkgs; [ neovim git ];
  system.stateVersion = "23.11"; # Did you read the comment?
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  
  # Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc.automatic = true;
  nix.gc.dates = "20:00";
  nixpkgs.config.allowUnfree = true;
}
