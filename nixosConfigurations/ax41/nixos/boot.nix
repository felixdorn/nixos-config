{pkgs, ...}: {
  boot = {
    loader.grub = {
      enable = true;
      device = "/dev/nvme0n1";

      mirroredBoots = [
        {
          devices = ["/dev/nvme1n1"];
          path = "/boot-fallback";
        }
      ];
    };

    initrd.network = {
      enable = true;
      ssh = {
        enable = true;
        port = 2220;
        hostKeys = ["/nix/secret/initrd/ssh_host_ed25519_key"];
      };
    };

    swraid = {
      enable = true;
      mdadmConf = ''
        HOMEHOST ax41
      '';
    };
  };
}
