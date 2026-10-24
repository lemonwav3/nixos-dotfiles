{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    prismlauncher
    lutris
    gamemode
    protonplus
];

  programs.steam.enable = true;
  programs.gamescope.enable = true;

  services.flatpak.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
