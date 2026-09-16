{ config, lib, pkgs, ...}:
{
  environment.systemPackages = with pkgs;[
  obsidian
  krita
  scilab-bin
  onlyoffice-desktopeditors
  thunderbird
  bitwarden-desktop
  megasync
  picard
  ];
}
