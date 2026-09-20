{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./disko.nix
    ./drives.nix

    ../../modules/desktop.nix
    ../../modules/dev.nix
    ../../modules/gaming.nix
    ../../modules/wg.nix

    ../../modules/server/media-services.nix
    ../../modules/server/docker.nix
    ../../modules/server/nginx.nix
    # ../../modules/server/mc.nix
  ];

  # AMD GPU tooling
  systemd.packages = [ pkgs.lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];
  environment.systemPackages = [ pkgs.lact ];
}
