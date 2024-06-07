{pkgs, ...}: {
  services.greetd = let
    tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
    session = "${pkgs.hyprland}/bin/Hyprland";
    username = "default";
  in {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${tuigreet} --greeting 'Smile :)' --asterisks --remember --remember-user-session --time --cmd ${session}";
        user = "default";
      };
      default_session = initial_session;
    };
  };
}
