{ config, lib, pkgs, ... }:

{
  imports = [
    ./modules/home/shell.nix
    ./modules/home/packages.nix
    ./modules/home/waybar.nix
    ./modules/home/hypr.nix
    ./modules/home/foot.nix
    ./modules/home/wlogout.nix
    ./modules/home/lock.nix
  ];

  home.username = "tali";
  home.homeDirectory = "/home/tali";
  home.stateVersion = "26.05";
}
