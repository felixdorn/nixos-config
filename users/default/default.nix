{ pkgs, config, inputs, lib, ... }:

{
  imports = lib.filesystem.listFilesRecursive ./modules;

  home.username = "default";
  home.homeDirectory = "/home/default";
  home.stateVersion = "23.11"; # Please read the comment before changing.
  home.packages = [
  ];
}
