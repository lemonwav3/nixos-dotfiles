{ config, ... }:
let
  col=config.lib.stylix.colors;
in
{
  home.file.".config/hypr" = {
    source = ./hypr;
    recursive = true;
    force = true;
  };
  home.file.".config/hypr/colors.lua".text = 
  ''
    return {
      active_border = "rgba(${col.base0A}ee)",
      inactive_border = "rgba(${col.base03}aa)",
    }
  '';
  services.hyprpaper.enable = true;
}
