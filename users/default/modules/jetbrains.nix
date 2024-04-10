{ pkgs, ... }: let
  # Are these worth the bloat? 
  commonPlugins = [
    "github-copilot"
    "ideavim"
  ];
in {
  home.packages = with pkgs.jetbrains; [
    (plugins.addPlugins phpstorm ([] ++ commonPlugins))
#    (plugins.addPlugins clion ([] ++ commonPlugins))
#    (plugins.addPlugins rust-rover ([] ++ commonPlugins))
#    (plugins.addPlugins goland ([] ++ commonPlugins))
#    (plugins.addPlugins rust-rover ([] ++ commonPlugins))
    
  ];
}
