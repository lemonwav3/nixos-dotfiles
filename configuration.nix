{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/system/styling.nix
      ./modules/system/boot.nix
      ./modules/system/power.nix
      ./modules/system/networking.nix
      ./modules/system/locale.nix
      ./modules/system/display.nix
      ./modules/system/services.nix
      ./modules/system/users.nix
      ./modules/system/system.nix
      ./modules/system/productivity.nix
      ./modules/system/rest.nix
    ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
