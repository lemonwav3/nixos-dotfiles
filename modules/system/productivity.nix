{ config, lib, pkgs, ...}:
{
  environment.systemPackages = with pkgs;[
  obsidian
  krita
  onlyoffice-desktopeditors
  thunderbird
  bitwarden-desktop
  megasync
  picard
  vesktop
  ];
}
