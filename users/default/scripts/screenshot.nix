{pkgs, ...}:
pkgs.writeShellApplication {
  name = "screenshot";

  runtimeInputs = with pkgs; [grim slurp imagemagick swappy];

  text = ''grim -g $(slurp) - | convert - -shave 1x1 PNG:- | wl-copy | swappy -f -'';
}
