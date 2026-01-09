{
  config,
  lib,
  pkgs,
  ...
}:

{
  # 1. Create a service to generate the certs
  systemd.services.generate-nginx-certs = {
    description = "Generate self-signed certificates for Nginx";
    wantedBy = [ "multi-user.target" ];
    before = [ "nginx.service" ]; # Ensure certs exist before Nginx starts

    serviceConfig = {
      Type = "oneshot";
      UMask = "0077";
    };

    script = ''
      dir="/var/lib/nginx/certs"
      mkdir -p "$dir"
      if [ ! -f "$dir/selfsigned.crt" ]; then
        ${pkgs.openssl}/bin/openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
          -keyout "$dir/selfsigned.key" \
          -out "$dir/selfsigned.crt" \
          -subj "/CN=calebsvn.lan" \
          -addext "subjectAltName = DNS:calebsvn.lan, DNS:*.calebsvn.lan"
        chown -R nginx:nginx "$dir"
      fi
    '';
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;

    virtualHosts."jellyfin.calebdtn.lan" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:8096";
      };
    };
  };
}
