{ pkgs, ... }: {
 sops.defaultSopsFile = ./secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/persist/home-xilef/.config/sops/age/keys.txt";

  sops.secrets = {
    "scaleway/access_key_id" = {};
    "scaleway/secret_access_key" = {};

    "restic/password" = {
      owner = "restic";
    };

    "pwd" = {
     	neededForUsers = true;
    };
     };

       environment.systemPackages = with pkgs; [ sops ];
}
