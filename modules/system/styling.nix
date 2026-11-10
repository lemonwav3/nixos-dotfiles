{ config, lib, pkgs, ... }:
let
  theme = import ../../themes/gruvbox-dark-medium.nix;
in
{
  # Add Stylix
  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.base16Scheme = theme;
  stylix.polarity = theme.polarity;
  stylix.opacity.terminal = 0.9;
  stylix.image = ../../wallpapers/wallpaper.png;
  stylix.fonts.monospace = {
    name = "JetBrainsMono Nerd Font";
    package = pkgs.nerd-fonts.jetbrains-mono;
  };
  stylix.cursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  # Fonts
  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
}
