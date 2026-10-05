{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./disko.nix
    ./ninja.nix

    ../../modules/desktop.nix
    ../../modules/dev.nix
    ../../modules/vm.nix
  ];

  environment.systemPackages = with pkgs; [
    # battery stuff
    upower
  ];

  networking.hosts = {
    "127.0.0.1" = [
      "onprem.asarel.bg"
      "web-api.onprem.asarel.bg"
      "unity-api.onprem.asarel.bg"
      "admin.onprem.asarel.bg"
      "pitboss.onprem.asarel.bg"
      "reporting.onprem.asarel.bg"
      "files.onprem.asarel.bg"
      "unity-files.onprem.asarel.bg"
      "percept-files.onprem.asarel.bg"
      "master-data.onprem.asarel.bg"
      "hazards.onprem.asarel.bg"
    ];

    "34.40.180.208" = [ "foxleigh-os.io" ];
    "34.40.241.101" = [ "piacentini-os.io" ];
  };

  services.xserver.libinput = {
    enable = true;
    # mouse.naturalScrolling = true;
    touchpad.naturalScrolling = true;
  };

  # Laptop specifics (power management, touchpad, ...) go here.
}
