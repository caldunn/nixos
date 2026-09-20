{
  config,
  lib,
  pkgs,
  ...
}:

{
  virtualisation.oci-containers = {
    backend = "docker";

    containers."traggo-server" = {
      image = "traggo/server:latest";
      autoStart = true;

      ports = [
        "3030:3030" # HTTP Management
      ];

      environment = {
        TRAGGO_DEFAULT_USER_NAME = "admin";
        TRAGGO_DEFAULT_USER_PASS = "password";
      };
      volumes = [
        "./traggodata:/opt/traggo/data"
      ];
    };

  };
}
