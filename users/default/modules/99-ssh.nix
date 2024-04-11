{ pkgs, ... }: {
  programs.ssh  = {
    enable = true;

    matchBlocks = {
      # [name].hostname = '[ip]'
    };
  };
}
