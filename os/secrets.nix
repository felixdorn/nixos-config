{ pkgs, ... }: {
  sops =  {
    defaultSopsFile = ./../secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/default/.config/sops/age/keys.txt";
  };

  environment.systemPackages = [ pkgs.sops ];
}
