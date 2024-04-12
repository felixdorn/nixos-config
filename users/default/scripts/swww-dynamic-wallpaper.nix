{ pkgs, ... }: let
  wallpapers = ./../data/wallpapers;
in pkgs.writeShellApplication {
  name = "__swww-dynamic-wallpaper";

  runtimeInputs = with pkgs; [ swww ];

  text = ''
  INTERVAL=300

    while true; do
      find "${wallpapers}" -type f \
	| while read -r img; do
	echo "$((RANDOM % 1000)):$img"
	done \
	| sort -n | cut -d':' -f2- \
	| while read -r img; do
	swww img --transition-fps 60 --transition-type wave "$img"
	sleep $INTERVAL
	done
	done
    '';
}
