args @ {
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ (lib.filesystem.listFilesRecursive ./nixos);

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-26ff45a1-116c-4196-80ec-0cb8c595c5d6".device = "/dev/disk/by-uuid/26ff45a1-116c-4196-80ec-0cb8c595c5d6";

  # Docker
  virtualisation.docker.enable = true;
  systemd.network.wait-online.ignoredInterfaces = [
    "docker0"
  ];

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
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  console.keyMap = "fr";

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    font-awesome
    powerline-fonts
    powerline-symbols
    jetbrains-mono
    (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
  ];

  # Printing
  services.printing.enable = true;

  # GnuPG
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # TLP & Thermald
  services.thermald.enable = true;
  services.tlp = {
    enable = true;
    settings.TLS_ENABLE = true;
  };

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

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true;
    };
  };
  services.blueman.enable = true;
  systemd.user.services.mpris-proxy = {
    # Support Bluetooth headset buttons to control media players
    description = "Mpris proxy";
    after = ["network.target" "sound.target"];
    wantedBy = ["default.target"];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };
  hardware.enableAllFirmware = true;

  # Default shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Tailscale
  services.tailscale.enable = true;

  # PC/SD Daemon (to support CCID)
  services.pcscd.enable = true;

  # udisksd  (to query and manipulate storage devices)
  services.udisks2.enable = true;

  # Users
  sops.secrets."default/password" = {
    neededForUsers = true;
  };
  users.users.default = {
    home = "/home/default";
    createHome = true;
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Félix Dorn";
    hashedPasswordFile = config.sops.secrets."default/password".path;
    extraGroups = ["networkmanager" "wheel" "docker" "lp" "audio" "video"];
  };

  # Home Manager
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users.default = import ./homeManager/default.nix;
  };

  # System
  environment.systemPackages = with pkgs; [
    xdg-utils
    gnome.seahorse
    gnome.nautilus
    neovim
    git
  ];

  system.stateVersion = "23.11"; # Did you read the comment?
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
  };

  # Nix
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.gc.automatic = true;
  nix.gc.dates = "20:00";
  nixpkgs.config.allowUnfree = true;

  services.gnome.gnome-keyring.enable = true;
  services.dnsmasq = {
    enable = true;
    resolveLocalQueries = true;
    settings = {
      no-resolv = true;
      server = [
        "1.1.1.1"
        "8.8.8.8"
        "8.8.8.4"
      ];
      address = "/test/127.0.0.1";
    };
  };
  security.pam.services.greetd.enableGnomeKeyring = true;
  services.hardware.bolt.enable = true;
  services.fwupd.enable = true;
  services.fwupd.extraRemotes = ["lvfs-testing"];
}
