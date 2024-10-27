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
    # wget
    kitty
    # git
    # clang
    # nix-output-monitor
    # nodejs_22
    # go
    # dotnetCorePackages.sdk_8_0_3xx
    # gcc
    # rustup
    # nixfmt-rfc-style
    # tmux
    # openssl
  ];
}
