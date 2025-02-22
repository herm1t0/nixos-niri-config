# Installation

Disk partitioning
```shell
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount github:herm1t0/nixos-niri-config/disko.nix
```
System installation
```shell
sudo nix run 'github:nix-community/disko/latest#disko-install' -- --flake 'github:herm1t0/nixos-niri-config/' --disk main /dev/sda
```
