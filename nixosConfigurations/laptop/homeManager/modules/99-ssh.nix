{pkgs, ...}: {
  programs.ssh = {
    enable = true;

    matchBlocks = {
      ax41 = {
        hostname = "65.109.99.46";
        user = "root";
        port = 2200;
      };
    };
  };
}
