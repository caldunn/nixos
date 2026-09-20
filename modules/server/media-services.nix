{ config, pkgs, ... }:
{

  services.jellyfin = {
    enable = true;
    openFirewall = true;

    # lets just run it as my user for simplicity. It does not really matter
    user = "caleb";
  };

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];

  hardware.graphics = {
    extraPackages = with pkgs; [
      vpl-gpu-rt
    ];
  };

}
