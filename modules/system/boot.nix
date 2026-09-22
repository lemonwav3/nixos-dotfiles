{ config, lib, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # zram swap: guards rebuilds/compilation against OOM (no disk swap currently).
  zramSwap.enable = true;
}
