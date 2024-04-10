{ pkgs, ... }: {
  programs.git = {
    enable = true;

    attributes = [ "* text=auto" ];
    delta.enable = true;
    ignores = [
      "idea"
      ".vscode"
      "__pycache__"
      "venv"
      "node_modules"
    ];
    lfs.enable = true;

    userEmail = "git@felixdorn.fr";
    userName = "Félix Dorn";

    extraConfig = {
     init.defaultBranch = "master";
     core = { whitespace = "trailing-space,space-before-tab"; };
     color = { ui = "auto"; };
     merge = { ff = "only"; };
     rebase = { autoSquash = "true"; };
     github = { user = "felixdorn"; };
   };
  };
}
