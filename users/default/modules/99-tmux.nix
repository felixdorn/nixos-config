{pkgs, ...}: {
  programs.tmux = {
    enable = true;

    prefix = "C-a";
    keyMode = "vi";
    baseIndex = 1;
    mouse = true;
    clock24 = true;

    # By default, typing C-bn does not work because
    # tmux is waiting for an escape sequence,
    # setting escape-time to 1 fixes that.
    escapeTime = 1;

    extraConfig = ''
      source-file ${./../data/tmux-gruvbox-dark.conf}

      unbind %
      bind-key -T prefix C-T clock-mode
      bind-key -T prefix t split-window -h
      bind-key -T prefix = split-window -v

      bind-key -T prefix r source-file ~/.config/tmux/tmux.conf\; display "Reloaded!"
      bind-key -T prefix c new-window -c "#{pane_current_path}"

      bind-key -n M-1 select-window -t :=1
      bind-key -n M-2 select-window -t :=2
      bind-key -n M-3 select-window -t :=3
      bind-key -n M-4 select-window -t :=4
      bind-key -n M-5 select-window -t :=5
      bind-key -n M-6 select-window -t :=6
      bind-key -n M-7 select-window -t :=7
      bind-key -n M-8 select-window -t :=8
      bind-key -n M-9 select-window -t :=9

      set -s copy-command 'wl-copy'
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi V send-keys -X rectangle-toggle
        unbind -T copy-mode-vi Enter
        bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel wl-copy
        bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel wl-copy
        bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel wl-copy
    '';

    plugins = with pkgs.tmuxPlugins; [
      resurrect
      continuum
    ];
  };
}
