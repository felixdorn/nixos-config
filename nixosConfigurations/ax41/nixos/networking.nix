{pkgs, ...}: {
  boot.kernelParams = ["ip=65.109.99.46::65.109.99.1:255.255.255.192:ax41:enp41s0:off"];

  networking = {
    nameservers = ["1.1.1.1" "8.8.8.8"];
    hostName = "ax41";
    useDHCP = false;
    interfaces."enp41s0" = {
      ipv4.addresses = [
        {
          address = "65.109.99.46";
          prefixLength = 26;
        }
      ];
      ipv6.addresses = [
        {
          address = "2a01:4f9:3080:2428::2";
          prefixLength = 64;
        }
      ];
    };
    defaultGateway = "65.109.99.1";
    defaultGateway6 = {
      interface = "enp41s0";
      address = "fe80::1";
    };
  };
}
