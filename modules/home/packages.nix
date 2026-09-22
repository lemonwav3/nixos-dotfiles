{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.wlogout pkgs.brightnessctl ];
}