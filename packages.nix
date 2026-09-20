{
  config,
  lib,
  pkgs,
  ...
}:

{
  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    winbox
    bitwarden-desktop
    neovim
    wget
    kitty
    firefox
    rustup
    python314
    gimp

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

    #speed tests
    iperf

    ungoogled-chromium

    # some of my keys are broken;
    maliit-keyboard

    # qr code generator
    qrencode
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/caleb/nix";
  };

  nonfoss = [
    "spotify"
    "winbox"
  ];
}
