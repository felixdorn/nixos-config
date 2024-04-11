{ pkgs }: 

pkgs.writeShellApplication {
  name = "tmux-sessionizer";

  runtimeInputs = with pkgs; [ fzf tmux ];

  text = ''
#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
  selected=$1
else
  selected=$(find ~/Projects ~/Knowledge -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)

if ! tmux has-session -t "$selected_name" 2> /dev/null; then
  tmux new-session -d -s "$selected_name" -c "$selected" 
fi

if [ -z "''${TMUX+x}" ]; then
  tmux attach -t "$selected_name"
else
  tmux switch-client -t "$selected_name"
fi
'';
}
