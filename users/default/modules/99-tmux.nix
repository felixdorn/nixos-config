{ pkgs, ... }: {
  programs.tmux = {
    enable = true;

    extraConfig = ''
      set -g base-index 1
      bind r source-file ~/.tmux.conf
      
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      ${builtins.readFile ./../data/tmux-gruvbox-dark.conf}
   '';
  };
}
