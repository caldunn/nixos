{ ... }:

{
  imports = [
    ./hardware.nix

    ../../modules/desktop.nix
    ../../modules/dev.nix
  ];

  # Laptop specifics (power management, touchpad, ...) go here.
}
