{ config, lib, pkgs, ... }:
{
  imports = [
    ./modules/home/shell.nix
    ./modules/home/packages.nix
    ./modules/home/waybar.nix
    ./modules/home/foot.nix
    ./modules/home/wlogout.nix
    ./modules/home/desktop.nix
  ];

  home.username = "game";
  home.homeDirectory = "/home/game";
  home.stateVersion = "26.05";

  home.file.".config/hypr" = {
    source = ./config/hypr-game;
    recursive = true;
    force = true;
  };

  services.hyprpaper.enable = true;
  stylix.image = lib.mkForce ./wallpapers/wallpaper.png;

  my.waybar.center = [ "custom/steam" ];
}
