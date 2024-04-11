{ pkgs, ... }: {
  services.udiskie = {
    automount = true;
    enable = true;
    notify = true;
  };

  # udiskie requires the Udisk2 DBus service
  # which does not exist by default
  services.udisks2.enable = true; 
}
