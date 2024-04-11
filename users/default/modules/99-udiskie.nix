{ pkgs, ... }: {
  # Don't forget that udisks2 is enabled
  # in your system configuration for udiskie to work
  services.udiskie = {
    automount = true;
    enable = true;
    notify = true;
  };
}
