{
  config,
  lib,
  pkgs,
  ...
}:

{
  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.10.10.5/32" ];
    privateKeyFile = "/home/caleb/.config/wg/private.key";
    peers = [
      {
        publicKey = "zosAf+DMivaLmsgnDdpXabSeIU4whco1DtsFTjlXOHk=";
        allowedIPs = [
          "10.0.0.0/16"
        ];
        endpoint = "124.187.104.221:51820";
        persistentKeepalive = 25;
      }
    ];
  };
}
