{
  config,
  lib,
  pkgs,
  ...
}:

{
  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    neovim
    wget
    kitty
    git
    iperf
    firefox
    rustup
    python314
    nginx

    waybar
    tofi

    xfce.thunar

    neofetch
    transmission_4-gtk

    jdk21_headless

    # dev
    clang

    kdePackages.filelight

    # nonsteam launcher
    zenity
    jq
    unzip

    # image utils
    imagemagick

    # clipboard manager
    cliphist
    wl-clipboard

    #bluetooth
    bluetui

    # content
    mpv
    spotify

    # process management
    btop
    lsof

    # notifications
    dunst

    #speed tests
    iperf
  ];

  nonfoss = [ "spotify" ];
}
