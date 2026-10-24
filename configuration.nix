{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/system
  ];

  networking.hostName = "nixos-machine"; 
  system.stateVersion = "26.05";
}
