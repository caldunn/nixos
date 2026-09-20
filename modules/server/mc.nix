{ config, pkgs, ... }:

{
  systemd.services.mc-gtnh = {

    path = [ pkgs.jdk ];
    description = "Greg Tech New Horizons daemon";

    serviceConfig = {
      Type = "simple";
      User = "mc-gtnh";
      Group = "mc-gtnh";

      WorkingDirectory = "/var/lib/mc/gtnh";
      ExecStart = "${pkgs.bash}/bin/bash /var/lib/mc/gtnh/startserver-java9.sh";

      Restart = "always";
      RestartSec = "5s";

      StandardOutput = "journal";
      StandardError = "journal";
    };

    wantedBy = [ "multi-user.target" ];
  };

  users.users.mc-gtnh = {
    isSystemUser = true;
    group = "mc-gtnh";
    home = "/var/lib/mc/gtnh";
  };

  users.groups.mc-gtnh = { };
}
