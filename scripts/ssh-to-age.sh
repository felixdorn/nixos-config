#!/usr/bin/env bash

if [ $(whoami | xargs) != "default" ]; then
  echo -e "\033[0;41mThis script expects to be run from the 'default' user.\033[0m"
  exit 1
fi

if [ ! -f /home/default/.ssh/id_rsa ]; then
  echo -e "\033[0;41mMissing SSH key in /home/default/.ssh/id_rsa\033[0m"
  exit 1
fi

nix run nixpkgs#ssh-to-age  -- -private-key -i /home/default/.ssh/id_rsa > /home/default/.config/sops/age/keys.txt
