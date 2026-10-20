{ config, lib, pkgs, ... }:

{
  home.file.".config/hypr" = {
    source = ../../config/hypr;
    recursive = true;
    force = true;
  };
  services.hyprpaper.enable = true;
}
