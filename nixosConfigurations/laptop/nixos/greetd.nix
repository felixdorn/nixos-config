{pkgs, ...}: {
  services.greetd = let
    tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
    session = "${pkgs.hyprland}/bin/Hyprland";
    username = "default";
  in {
    enable = true;
    settings = {
      default_session = {
        command = "${tuigreet} --greeting 'Smile :)' --asterisks --remember --remember-user-session --time --cmd ${session}";
        user = "default";
      };
      initial_session = {
        command = session;
        user = username;
      };
    };
  };
}
