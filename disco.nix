{
  inputs.disko.url = "github:nix-community/disko/latest";

  outputs = { disko }: {
    disko.devices = {
      disk = {
        main = {
          device = "/dev/some-device"; # Must be overwrited from the commandline
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              boot = {
                size = "1M";
                type = "EF02"; # for grub MBR
              };
              root = {
                size = "100%";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                };
              };
            };
          };
        };
      };
    };
  };
}
