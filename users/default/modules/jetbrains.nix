{ pkgs, ... }: let
  # Are these worth the bloat? 
  commonPlugins = [
    "github-copilot"
    "wakatime"
    "rainbow-brackets"
    "key-promoter-x"
    "nyan-progress-bar"
    "env-files-support"
    "ideavim"
    "csv-editor"
    "docker"
    "gruvbox-theme"
  ];
in {
  home.packages = with pkgs; [
    (jetbrains.plugins.addPlugins jetbrains.phpstorm [ 
      "laravel-idea"
      "tailwnd-css"
      "tailwind-formatter"
      "tailwind-css-smart-completions"
      "vue-js"
    ] ++ commonPlugins)
  ];
}
