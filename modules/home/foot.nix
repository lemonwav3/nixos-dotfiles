{ config, lib, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    settings.main = {
      font = lib.mkForce "JetBrainsMono Nerd Font:size=16";
      pad = "4x4";
      "initial-color-theme" = "dark";
    };
  };
}