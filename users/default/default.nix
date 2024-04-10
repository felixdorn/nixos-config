{ pkgs, config, inputs, lib, ... }:

{
  imports = lib.filesystem.listFilesRecursive ./modules;

  home.username = "default";
  home.homeDirectory = "/home/default";
  home.stateVersion = "23.11"; # Please read the comment before changing.
  home.packages = with pkgs; [
    spotify
    # These naughty apps are glorified web pages, use a browser instead. 
    # discord
    # whatsapp-for-linux
    # telegram-desktop 
    libreoffice
    obsidian
    pkgs.jetbrains.phpstorm
    pkgs.jetbrains.goland
    pkgs.jetbrains.clion

    yubikey-manager
    bat
    fzf
    neofetch # I use ~Arch~ NixOS, btw
    ripgrep
    fd # for neovim (telescope)
    unzip # for the x alias to work
  ];
}
