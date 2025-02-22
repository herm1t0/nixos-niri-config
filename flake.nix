{
  inputs = {
    
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    inputs.disko.url = "github:nix-community/disko/latest";
    inputs.disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, disko ... }@inputs:
      let
        system = "x86_64-linux";
        user = "herm1t";
        hostname = "PC-1001";
        homeStateVersion = "24.11";
        
      in {
        nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
          inherit inputs system hostname;

          modules = [
            disko.nixosModules.disko
            {
              disko.devices = {
                disk = {
                  main = {
                    device = "/dev/sda";
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
            }
          ];
        };

        homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = {
            inherit inputs homeStateVersion user;
          };
          
          modules = [
            
          ];
        };
      };

}
