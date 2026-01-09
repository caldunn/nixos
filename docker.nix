{
  config,
  lib,
  pkgs,
  ...
}:

{
  virtualisation.oci-containers = {
    backend = "docker";
    containers."omada-controller" = {
      image = "mbentley/omada-controller:latest";
      autoStart = true;

      ports = [
        "8088:8088" # HTTP Management
        "8043:8043" # HTTPS Management
        "29810:29810/udp" # Discovery
        "29811:29811" # Management
        "29812:29812" # Management
        "29813:29813" # Management
        "29814:29814" # Management
      ];

      environment = {
        TZ = "Australia/Perth";
        MANAGE_HTTP_PORT = "8088";
        MANAGE_HTTPS_PORT = "8043";
      };
      volumes = [
        "/var/lib/omada/data:/opt/tplink/EAPController/data"
        "/var/lib/omada/logs:/opt/tplink/EAPController/logs"
      ];
    };
  };
}
