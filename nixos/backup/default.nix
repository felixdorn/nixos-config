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

  systemd.services."backup" = let
    env = "AWS_ACCESS_KEY_ID=${config.sops.secrets."scaleway/access_key_id".path} AWS_SECRET_ACCESS_KEY=$(cat ${config.sops.secrets."scaleway/secret_access_key".path})";
  in {
    script = "/run/wrappers/bin/restic --password-file ${config.sops.secrets."restic/password".path} -r s3:s3.fr-par.scw.cloud/xilef backup /persist";
    serviceConfig = {
      Type = "oneshot";
      User = "restic";
    };
  };

  security.wrappers.restic = {
    source = "${pkgs.restic.out}/bin/restic";
    owner = "restic";
    group = "users";
    permissions = "u=rwx,g=,o=";
    capabilities = "cap_dac_read_search=+ep";
  };

environment.systemPackages = with pkgs; [ restic ];
}