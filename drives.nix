{ config, pkgs, ... }:

{
  # Media drive
  fileSystems."/mnt/biggus" = {
    device = "/dev/disk/by-uuid/cdb038d9-d1f1-412b-9cf3-0489f696cd27";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
    ];

  };
}
