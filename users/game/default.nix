{ config, lib, pkgs, ... }:
{
  imports = [
    ../../modules/home/shell.nix
    ../../modules/home/packages.nix
    ../../modules/home/waybar.nix
    ../../modules/home/foot.nix
    ../../modules/home/wlogout.nix
    ../../modules/home/desktop.nix
    ../../modules/home/hypr.nix
  ];

  home.username = "game";
  home.homeDirectory = "/home/game";
  home.stateVersion = "26.05";

  stylix.image = lib.mkForce ../../wallpapers/wallpaper.png;

  my.waybar.center = [ "custom/steam" ];
}
