{ config, lib, pkgs, ...}:
{
  environment.systemPackages = with pkgs;[
  obsidian
  krita
  (pkgs.callPackage ../../pkgs/scilab.nix { })
  onlyoffice-desktopeditors
  thunderbird
  bitwarden-desktop
  megasync
  picard
  vesktop
  ];
}
