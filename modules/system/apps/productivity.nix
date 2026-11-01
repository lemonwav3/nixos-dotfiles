{ config, lib, pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    krita
    obsidian
    inkscape
    (pkgs.callPackage ../../../pkgs/scilab.nix { })
    onlyoffice-desktopeditors
    thunderbird
    bitwarden-desktop
    megasync
    picard
    vesktop
    keepassxc
  ];
}
