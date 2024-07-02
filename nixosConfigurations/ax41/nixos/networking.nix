{pkgs, ...}: let
  ip4 = "65.109.99.46";
  ip6 = "2a01:4f9:3080:2428::2";
  gateway4 = "65.109.99.1";
  gateway6 = "fe80::1";
  interface = "enp41s0";
  hostName = "ax41";
in {
  boot.kernelParams = ["ip=${ip4}::${gateway4}:255.255.255.192:${hostName}:${interface}:off"];

  networking = {
    inherit hostName;
    useDHCP = false;
    interfaces.${interface} = {
      ipv4.addresses = [
        {
          address = ip4;
          prefixLength = 26;
        }
      ];
      ipv6.addresses = [
        {
          address = ip6;
          prefixLength = 64;
        }
      ];
    };
    defaultGateway = gateway4;
    defaultGateway6 = {
      inherit interface;
      address = gateway6;
    };
  };
}
