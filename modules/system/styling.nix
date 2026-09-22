{ config, lib, pkgs, ... }:

{
  # Add Stylix
  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.polarity = "dark";
  stylix.opacity.terminal = 0.9;
  stylix.base16Scheme = import ../../themes/gruvbox-dark-medium.nix;
  stylix.image = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/39/wallhaven-3911w9.jpg";
    sha256 = "sha256-dBmKkLR8yI1W7d9IRTOaErHf0KApSq0UsY5LWxAaSuA=";
  };
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
