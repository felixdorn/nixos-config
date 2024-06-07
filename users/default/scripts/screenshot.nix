{pkgs, ...}:
pkgs.writeShellApplication {
  name = "screenshot";

  runtimeInputs = with pkgs; [grim slurp swappy];

  text = ''grim -g "$(slurp -w 0)" -  | swappy -f -'';
}
