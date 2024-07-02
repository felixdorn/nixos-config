#!/usr/bin/env bash

if [ "$(whoami | xargs)" != "default" ]; then
  echo -e "\033[0;41mThis script expects to be run from the 'default' user.\033[0m"
  exit 1
fi

if [ ! -f /home/default/.ssh/id_ed25519 ]; then
  echo -e "\033[0;41mMissing SSH key in /home/default/.ssh/id_ed25519\033[0m"
  exit 1
fi

if [ ! -f /home/default/.config/sops/age/keys.txt ]; then
  mkdir -p /home/default/.config/sops/age

  nix run nixpkgs#ssh-to-age  -- -private-key -i /home/default/.ssh/id_ed25519 > /home/default/.config/sops/age/keys.txt
fi 

echo "Public key: $(nix shell nixpkgs#age -c age-keygen -y ~/.config/sops/age/keys.txt)"
