{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.displayManager = {
    enable = true;
    # videosDrivers = ["amdgpu"];
    gdm = {
      enable = true;
      wayland = true;
    };
  };

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
  programs.hyprland.enable = true;

  # hint electron apps to use wayland:o
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    pavucontrol
    pamixer

    # bluetooth gui
    overskride

    lact

    # Screenshotting
    slurp
    grim
    swappy
  ];

  fonts.packages =
    with pkgs;
    [
      inter
    ]
    # grab all nerdfonts cos i am lazy.
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

}
