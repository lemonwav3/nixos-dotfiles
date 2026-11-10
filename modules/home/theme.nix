{ config, lib, ... }:
let 
  themesDir = ../../themes;
  themeNames = 
    lib.mapAttrsToList (file: _: lib.removeSuffix ".nix" file)
    (lib.filterAttrs
      (file: type: type == "regular" && lib.hasSuffix ".nix" file)
      (builtins.readDir themesDir));

  cfg = config.my.theme;
  
  scheme = import (themesDir + "/${cfg.name}.nix");

in
{
  options.my.theme = {
    name = lib.mkOption {
      type = lib.types.enum themeNames;
      default = "gruvbox-dark-medium";
      description = "Theme file name in themes/, without .nix";
    };
    wallpaper = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Wallpaper for this user.";
    };

  };

  config.stylix = {
    base16Scheme = lib.mkForce scheme;
    polarity = lib.mkForce (scheme.polarity or "dark");
    image = lib.mkIf (cfg.wallpaper !=null) (lib.mkForce cfg.wallpaper);
  };
}
