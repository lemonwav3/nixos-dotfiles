{ ... }:
{
  home.file.".config/hypr" = {
    source = ./hypr;
    recursive = true;
    force = true;
  };
  services.hyprpaper.enable = true;
}
