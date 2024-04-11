args @ { inputs, config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./os/secrets.nix	
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-26ff45a1-116c-4196-80ec-0cb8c595c5d6".device = "/dev/disk/by-uuid/26ff45a1-116c-4196-80ec-0cb8c595c5d6";
  
  # Docker
  virtualisation.docker.enable = true;

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

  # GUI
  services.xserver = {
    enable = true;

    displayManager.sddm = { 
      enable = true;
      wayland.enable = true;
    };
  };
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Keyboard
  services.xserver.xkb = {
    layout = "fr";
    variant = "";
  };
  console.keyMap = "fr";

  # Fonts
  fonts.packages = with pkgs; [
    font-awesome
    powerline-fonts
    powerline-symbols
    (nerdfonts.override { fonts = [ "Hack" "NerdFontsSymbolsOnly" ]; })
  ];

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

  # Default shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # PC/SD Daemon (to support CCID)
  services.pcscd.enable = true;

  # Users
  users.users.default = {
    home = "/home/default";
    createHome = true;
    isNormalUser = true;
    shell = pkgs.zsh;
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
