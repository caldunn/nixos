{ config, pkgs, ... }:

{
  # 1. Enable GoFlow2 NetFlow/IPFIX collector service
  systemd.services.goflow2 = {
    description = "GoFlow2 NetFlow Collector";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.goflow2}/bin/goflow2 -listen netflow://0.0.0.0:2055 -format prometheus -format.bind 0.0.0.0:9808";
      Restart = "always";
      RestartSec = 5;
    };
  };

  # 2. Configure Prometheus to scrape GoFlow2 metrics
  services.prometheus = {
    enable = true;
    port = 9090;
    scrapeConfigs = [
      {
        job_name = "goflow2";
        scrape_interval = "15s";
        static_configs = [
          {
            targets = [ "127.0.0.1:9808" ];
          }
        ];
      }
    ];
  };

  # 3. Configure Grafana & auto-provision Prometheus datasource
  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_port = 3000;
        http_addr = "0.0.0.0";
      };
      security = {
        admin_user = "admin";
        admin_password = "ChangeMe123!"; # Change this on initial setup
        secret_key = "skibidi243";
      };
    };
    provision = {
      enable = true;
      datasources.settings.datasources = [
        {
          name = "Prometheus";
          type = "prometheus";
          access = "proxy";
          url = "http://127.0.0.1:9090";
          isDefault = true;
        }
      ];
    };
  };

  # 4. Open necessary firewall ports
  networking.firewall.allowedUDPPorts = [ 2055 ]; # NetFlow intake port
  networking.firewall.allowedTCPPorts = [ 3000 ]; # Grafana Web UI
}
