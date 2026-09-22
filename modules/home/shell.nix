{ config, lib, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use hyprland btw";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Tali";
      user.email = "example@example.com";
      init.defaultBranch = "main";
    };
  };
}