{ pkgs, config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    dotDir = ".config/zsh";

    shellAliases = {
      ssh = "TERM=xterm-256color ssh"; # TERM=alacritty causes issues
      amend = "git commit --amend";
      cd = "z";
      gs = "gss";
      "\\$" = "true && ";

      a = "php artisan";
      m = "php artisan migrate";
      mf = "php artisan migrate:fresh";
      mfs = "php artisan migrate:fresh --seed";


      switch = "sudo nixos-rebuild switch --flake .#default";
      switchf = "sudo nixos-rebuild switch --flake .#default --option eval-cache false";
      switchq = "sudo nixos-rebuild switch --fast --flake .#default";
    };

    initExtra = ''
      bindkey -s '^T' '^[utmux-sessionizer\n'
    '';

    oh-my-zsh = {
      enable = true;

      plugins = [ "extract" "sudo" "git" ];
    };
  };
}
