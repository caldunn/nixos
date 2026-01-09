{
  config,
  lib,
  pkgs,
  ...
}:

{

  nonfoss = [
    "steam"
    "steam-unwrapped"
    "discord"
  ];

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;

      gamescopeSession.enable = true;
      #   package = pkgs.steam.override
      #     {
      #     extraPkgs = pkgs': with pkgs'; [
      #       xorg.libXcursor
      #       xorg.libXi
      #       xorg.libXinerama
      #       xorg.libXScrnSaver
      #       libpng
      #       libpulseaudio
      #       libvorbis
      #       stdenv.cc.cc.lib # Provides libstdc++.so.6
      #       libkrb5
      #       keyutils
      #       # Add other libraries as needed
      #     ];
      #     };
    };

    #     gamescope = {
    #       enable = true;
    #       capSysNice = true;
    #     };

  };

  programs.gamemode.enable = true;
  users.users.caleb.extraGroups = [ "gamemode" ];

  environment.systemPackages = with pkgs; [
    discord
    lutris
    protonup-qt

    # mc
    prismlauncher
    r2modman
  ];
}
