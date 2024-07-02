# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./nixos/boot.nix
    ./nixos/networking.nix
  ];

  time.timeZone = "UTC";

  users.mutableUsers = false;
  users.users.root = {
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDagWON8xGwsDokVfy89C2sFcdS/4R2vFnzFajaV0Syf"];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  services.openssh = {
    enable = true;
    ports = [2200];
    settings.PermitRootLogin = "prohibit-password";
  };

  environment.etc."ssh/ssh_host_rsa_key".source = "/nix/persist/etc/ssh/ssh_host_rsa_key";
  environment.etc."ssh/ssh_host_rsa_key.pub".source = "/nix/persist/etc/ssh/ssh_host_rsa_key.pub";
  environment.etc."ssh/ssh_host_ed25519_key".source = "/nix/persist/etc/ssh/ssh_host_ed25519_key";
  environment.etc."ssh/ssh_host_ed25519_key.pub".source = "/nix/persist/etc/ssh/ssh_host_ed25519_key.pub";
  environment.etc."machine-id".source = "/nix/persist/etc/machine-id";

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [80 443] ++ config.services.openssh.ports;

  system.stateVersion = "24.11"; # Did you read the comment?
}
