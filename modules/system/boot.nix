{ config, lib, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;  # keeps /boot from filling up
  zramSwap.enable = true;  # guards rebuilds against OOM (no disk swap)
}
