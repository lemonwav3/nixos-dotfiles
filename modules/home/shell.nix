{ config, lib, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use hyprland btw";
    };
  };

  programs.kitty.enable = true;
  programs.wofi.enable = true;
}
