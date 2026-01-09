{
  disko.devices = {
    disk = {
      # Replace this with your actual disk's ID
      main = {
        type = "disk";
        # device = "/dev/nvme1n1";
        device = "/dev/disk/by-id/nvme-Lexar_SSD_NM790_4TB_QER497R000651P220J";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              start = "1M";
              end = "513M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "/@root" = {
                    mountpoint = "/";
                    mountOptions = [
                      "noatime"
                      "compress=zstd:3"
                    ];
                  };
                  "/@home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "noatime"
                      "compress=zstd:3"
                    ];
                  };
                  "/@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "noatime"
                      "compress=zstd:3"
                      "space_cache=v2"
                    ];
                  };
                  "/@snapshots" = {
                    mountpoint = "/.snapshots";
                    mountOptions = [
                      "noatime"
                      "compress=zstd:3"
                    ];
                  };
                  "/@steam" = {
                    mountpoint = "/steam";
                    mountOptions = [
                      "noatime"
                      "nodatacow"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
