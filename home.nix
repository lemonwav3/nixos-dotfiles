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
    ./modules/home/desktop.nix
    ./modules/home/nvf.nix
  ];

  home.username = "tali";
  home.homeDirectory = "/home/tali";
  home.stateVersion = "26.05";

  my.waybar.center = [
    "custom/librewolf" "custom/thunderbird" "custom/obsidian" "custom/krita" "custom/steam"
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "Tali";
      user.email = "example @ example.com";
      init.defaultBranch = "main";
    };
  };
}
