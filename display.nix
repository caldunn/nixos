{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.displayManager = {
    noctalia-greeter = {
      enable = true;
      # passwordlessSyncUsers = [ "caleb" ];
      settings = {
        appearance = {
          hide_logo = true;
        };

      };
      cursorTheme = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
      };

    };
  };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      #   mesa
      vulkan-tools
    ];
  };
  # services.xserver.videoDrivers = [ "amdgpu" ];

  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];

  # hardware.opengl = {
  # enable = true;
  # driSupport = true;
  # driSupport32Bit = true;
  # };

  # Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # hint electron apps to use wayland:o
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    pavucontrol
    pamixer

    lact

    adw-gtk3
    nwg-look
  ];

  fonts.packages =
    with pkgs;
    [
      inter
    ]
    # grab all nerdfonts cos i am lazy.
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

}
