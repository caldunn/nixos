
{
  config,
  lib,
  pkgs,
  ...
}:


{
  services.xserver = {
      enable = true;
      # videosDrivers = ["nvidia"];
      displayManager.gdm = {
          enable = true;
          wayland = true;
      };
  };
  
  hardware = {
    opengl.enable = true;
  };

  # Hyprland 
  programs.hyprland.enable = true;
  # hint electron apps to use wayland:o
  environment.sessionVariables.NIXOS_OZONE_WL = "1";


}
