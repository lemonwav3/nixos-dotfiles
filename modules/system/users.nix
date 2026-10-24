{ config, lib, pkgs, ... }:
{
  users.users."tali" = {
    isNormalUser = true;
    description = "T";
    homeMode = "700";
    extraGroups = [ "wheel" "networkmanager"];
  };

  users.groups.game = { };
  users.users.game = {
    isNormalUser = true;
    description = "Games (isolated)";
    group = "game";
    homeMode = "700";
    extraGroups = [ ];  # No wheel, input or networkmanager
  };
  # One-way drpo folder: tali writes, game reads
  systemd.tmpfiles.rules = [
    "d /srv/game-share 0750 tali game -"
  ];
}
