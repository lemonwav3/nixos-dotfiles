{ congig, lib, pkgs, ... }:
{
  users.groups.game = { };
  users.users.game = {
    isNormalUser = true;
    description = "Games (isolated)";
    group = "game";
    homeMode = "700";
    extraGroups = [ ];  # No wheel, input or networkmanager
  };
  
  services.flatpak.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  
  # One-way drpo folder: tali writes, game reads
  systemd.tmpfiles.rules = [
    "d /srv/game-share 0750 tali game -"
  ];
}
