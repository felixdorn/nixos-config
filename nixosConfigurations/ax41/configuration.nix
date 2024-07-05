{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./nixos/boot.nix
    ./nixos/networking.nix
  ];

  time.timeZone = "UTC";

  users.mutableUsers = false;
  users.users.root = {
    extraGroups = ["docker"];
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDagWON8xGwsDokVfy89C2sFcdS/4R2vFnzFajaV0Syf"];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  services.openssh = {
    enable = true;
    ports = [2200];
    settings.PermitRootLogin = "prohibit-password";
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings = {
    data-root = "/var/lib/docker";
  };

  services.traefik = let
    trustedIPs = [
      # Cloudflare
      "173.245.48.0/20"
      "103.21.244.0/22"
      "103.22.200.0/22"
      "103.31.4.0/22"
      "141.101.64.0/18"
      "108.162.192.0/18"
      "190.93.240.0/20"
      "188.114.96.0/20"
      "197.234.240.0/22"
      "198.41.128.0/17"
      "162.158.0.0/15"
      "104.16.0.0/13"
      "104.24.0.0/14"
      "172.64.0.0/13"
      "131.0.72.0/22"
      "2400:cb00::/32"
      "2606:4700::/32"
      "2803:f800::/32"
      "2405:b500::/32"
      "2405:8100::/32"
      "2a06:98c0::/29"
      "2c0f:f248::/32"
    ];
  in {
    enable = true;
    dynamicConfigOptions = {
      http.routers = {
        "blank.xfe.li" = {
          rule = "Host(`blank.xfe.li`)";
          service = "blank-xfe-li";
        };
        "policies.xfe.li" = {
          rule = "Host(`policies.xfe.li`)";
          service = "policies-xfe-li";
        };
        "preview.biosecurity.world" = {
          rule = "Host(`preview.biosecurity.world`)";
          service = "preview-biosecurity-world";
        };
        "iconsnatch.forevue.org" = {
          rule = "Host(`iconsnatch.forevue.org`)";
          service = "iconsnatch-forevue-org";
        };
        "draw.xfe.li" = {
          rule = "Host(`draw.xfe.li`)";
          service = "draw-xfe-li";
        };
        "webmail.forevue.org" = {
          rule = "Host(`webmail.forevue.org`)";
          service = "webmail-forevue-org";
        };
        "smtp.forevue.org" = {
          rule = "Host(`smtp.forevue.org`)";
          service = "noop@internal";
        };
        "l8.xfe.li" = {
          rule = "Host(`l8.xfe.li`)";
          service = "l8-xfe-li";
        };
        "rss.xfe.li" = {
          rule = "Host(`rss.xfe.li`)";
          service = "rss-xfe-li";
        };
      };

      http.services = {
        blank-xfe-li.loadBalancer.servers = [{url = "http://0.0.0.0:3003";}];
        policies-xfe-li.loadBalancer.servers = [{url = "http://0.0.0.0:3002";}];
        draw-xfe-li.loadBalancer.servers = [{url = "http://0.0.0.0:3004";}];
        l8-xfe-li.loadBalancer.servers = [{url = "http://0.0.0.0:3006";}];
        rss-xfe-li.loadBalancer.servers = [{url = "http://0.0.0.0:3007";}];
        preview-biosecurity-world.loadBalancer.servers = [{url = "http://0.0.0.0:3009";}];
        iconsnatch-forevue-org.loadBalancer.servers = [{url = "http://0.0.0.0:3001";}];
        webmail-forevue-org.loadBalancer.servers = [{url = "http://0.0.0.0:3005";}];
      };
    };
    staticConfigOptions = {
      entryPoints = {
        web = {
          address = ":80";
          asDefault = true;
          http.redirections.entrypoint = {
            to = "websecure";
            scheme = "https";
          };
          forwardedHeaders = {inherit trustedIPs;};
        };

        websecure = {
          address = ":443";
          asDefault = true;
          http.tls.certResolver = "letsencrypt";
          forwardedHeaders = {inherit trustedIPs;};
        };
      };

      log.level = "INFO";
      accessLog.filePath = "/var/lib/traefik/access.log";

      certificatesResolvers.letsencrypt.acme = {
        email = "postmaster@xfe.li";
        storage = "/var/lib/traefik/acme.json";
        httpChallenge.entryPoint = "web";
      };

      api = {
        dashboard = true;
        insecure = true;
      };
    };
  };

  environment.etc."ssh/ssh_host_rsa_key".source = "/nix/persist/etc/ssh/ssh_host_rsa_key";
  environment.etc."ssh/ssh_host_rsa_key.pub".source = "/nix/persist/etc/ssh/ssh_host_rsa_key.pub";
  environment.etc."ssh/ssh_host_ed25519_key".source = "/nix/persist/etc/ssh/ssh_host_ed25519_key";
  environment.etc."ssh/ssh_host_ed25519_key.pub".source = "/nix/persist/etc/ssh/ssh_host_ed25519_key.pub";
  environment.etc."machine-id".source = "/nix/persist/etc/machine-id";

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [80 443 25 465 587 143 993] ++ config.services.openssh.ports;

  system.stateVersion = "24.11"; # Did you read the comment?
}
