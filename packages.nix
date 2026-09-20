{
  config,
  lib,
  pkgs,
  ...
}:

{
  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    goflow2
    winbox
    bitwarden-desktop
    neovim
    wget
    kitty
    iperf
    firefox
    rustup
    python314
    nginx
    gimp

    waybar
    tofi

    thunar

    fastfetch
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

    ungoogled-chromium

    # some of my keys are broken;
    maliit-keyboard

    # qr code generator
    qrencode
  ];

  nonfoss = [
    "spotify"
    "winbox"
  ];
}
