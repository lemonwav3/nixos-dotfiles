{ config, pkgs, ... }:

{
  home.username = "tali";
  home.homeDirectory = "/home/tali";
  home.stateVersion = "26.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use hyprland btw";
    };
  };

  programs.git = {
    enable = true;
    userName = "Tali";
    userEmail = "example@example.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  home.file.".config/hypr" = {
    source = ./config/hypr;
    force = true;
  };
  home.file.".config/waybar" = {
    source = ./config/waybar;
    force = true;
  };
  home.file.".config/foot" = {
    source = ./config/foot;
    force = true;
  };
}
