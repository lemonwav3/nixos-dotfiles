{ config, lib, pkgs, ... }:

{
  home.file.".config/hypr" = {
    source = ../../config/hypr;
    force = true;
  };
}