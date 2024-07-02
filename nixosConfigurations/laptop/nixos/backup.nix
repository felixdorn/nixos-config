{ pkgs, config, ... }: {
  users.users.restic = {
    isSystemUser = true;
    createHome = true;
    group = "restic";
  };
  users.groups.restic = {};

  systemd.timers."backup" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "5m";
      Unit = "backup.service";
      OnCalendar = "daily";
      Persistent = true;
    };
  };

  sops.secrets."restic" = {
    owner = "restic";
    format = "dotenv";
    sopsFile = ./../secrets/systemd-backup.env;
  };

  systemd.services.backup = {
    script = "/run/wrappers/bin/restic backup --exclude={/dev,/media,/mnt,/proc,/nix,/run,/sys,/tmp,/var/tmp,.cache/,node_modules/,vendor/} --no-scan /";

    serviceConfig = {
      Type = "oneshot";
      User = "restic";
      EnvironmentFile=config.sops.secrets."restic".path;
    };
    unitConfig= {
      After = [ "sops-nix.service" ];
    };
  };


  security.wrappers.restic = {
    source = "${pkgs.restic.out}/bin/restic";
    owner = "restic";
    group = "users";
    permissions = "u=rwx,g=,o=";
    capabilities = "cap_dac_read_search=+ep";
  };

  environment.systemPackages = [ pkgs.restic ];
}


