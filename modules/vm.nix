{
  config,
  lib,
  pkgs,
  ...
}:

{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;
    };
  };
  users.users.caleb.extraGroups = [ "libvirtd" ];
  environment.systemPackages = with pkgs; [
    virt-manager
  ];

}
