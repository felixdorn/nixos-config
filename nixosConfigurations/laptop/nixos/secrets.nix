{pkgs, ...}: {
  sops = {
    defaultSopsFile = ./../secrets/default.yaml;
    defaultSopsFormat = "yaml";

    age.generateKey = true;
    age.sshKeyPaths = ["/home/default/.ssh/id_ed25519"];
    age.keyFile = "/var/lib/sops/keys.txt";
  };

  environment.systemPackages = [pkgs.sops];
}
