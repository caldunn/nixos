{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./drives.nix
    ./packages.nix
    ./display.nix

    ./global-options.nix

    # random stuff, this should go in an init.nix like file.
    ./qol.nix
    ./gaming.nix
    ./dev.nix
    ./media-services.nix
    ./docker.nix
    ./nginx.nix
    ./wg.nix
    # ./monitor.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking.hostName = "calebdtn"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Australia/Perth";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # Sick of my airpods connecting via this. I don't use a wireless mic anyways.
    wireplumber.extraConfig = {
      "10-airpods-a2dp-only" = {
        "monitor.bluez.properties" = {
          # This restricts the roles available to bluetooth devices
          "bluez5.roles" = [
            "a2dp_sink"
            "a2dp_source"
          ];

          # Optional: Enable SBC-XQ (XQ-Dual Channel) for better SBC quality
          # if you aren't using AAC/LDAC for some reason
          "bluez5.enable-sbc-xq" = true;
        };
      };
    };
  };

  #enable bluetooth
  hardware.bluetooth.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Keep it real :)
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.caleb = {
    isNormalUser = true;
    hashedPassword = "$y$j9T$MlKaZlQHFe.d6nMUPE9GA0$TPA2IP0nyHtwwUR.NtfyieGGbY88Z0dr/b4XT/KbAs0";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICXIv0wuhLkAMwgw46wGa/R7V/h5TJYTjT7MM6livs1B caleb@calebdta"
    ];
    extraGroups = [
      "wheel"
      "networkmanager"
    ]; # Enable ‘sudo’ for the user.
  };

  services.udisks2.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "25.05";

  nix.settings.allowed-users = [ "@wheel" ];

  # for some esp development.
  programs.nix-ld.enable = true;

}
