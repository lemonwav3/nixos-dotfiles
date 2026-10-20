{ config, lib, pkgs, ... }:
{
  services.mako.enable = true;               # notifications; Stylix themes it
  services.mako.settings.default-timeout = 5000;
  services.hyprpolkitagent.enable = true;    # GUI privilege prompts
  services.blueman-applet.enable = true;     # Bluetooth tray icon
  home.packages = [ pkgs.libnotify ];        # provides notify-send for testing
}
