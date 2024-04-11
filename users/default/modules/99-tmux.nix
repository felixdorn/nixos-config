{ pkgs, ... }: {
  programs.tmux = {
    enable = true;

    extraConfig = ''
      set -g base-index 1

      # By default, typing C-bn does not work because 
      # tmux is waiting for an escape sequence,
      # setting escape-time to 0 fixes that. 
      set -s escape-time 0

      bind r source-file ~/.tmux.conf
      bind c new-window -c "#{pane_current_path}"     
      
      set-window-option -g mode-keys vi

      ${builtins.readFile ./../data/tmux-gruvbox-dark.conf}
   '';

    plugins = with pkgs.tmuxPlugins; [
      resurrect
      continuum
    ];
  };


}
