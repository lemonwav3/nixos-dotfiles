{ config, pkgs, ... }:

{
  home.username = "tali";
  home.homeDirectory = "/home/tali";
  home.stateVersion = "26.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use hyprland btw";
    };
  };

  programs.git = {
    enable = true;
    userName = "Tali";
    userEmail = "example@example.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  home.packages = [ pkgs.wlogout ];

  programs.waybar = {
    enable = true;
    settings = [
      {
      layer = "top";
      position = "top";
      height = 30;
      spacing = 4;
      modules-left = [ "custom/launcher" "custom/sep" "cpu" "custom/sep" "memory" ];
      modules-center = [ "hyprland/workspaces" ];
      modules-right = [ "clock" "custom/sep" "custom/powermenu" "tray" ];
      "custom/launcher" = {
        format = " ";
        on-click = "rofi -show drun";
      };
      "custom/powermenu" = {
        format = " ";
        on-click = "wlogout";
      };
      "custom/sep" = {
        format = "|";
        interval = 0;
      };
      "hyprland/workspaces" = {
        format = "{name}";
      };
      clock = {
        format = "{:%a %d %b %H:%M}";
      };
      cpu = {
        format = "CPU: {usage}%";
        tooltip = false;
      };
      memory = {
        format = "Mem: {used}GiB";
      };
      tray = {
        spacing = 10;
      };
    }
    ];
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 14px;
      }
      window#waybar {
        background: #${config.lib.stylix.colors.base00};
        color: #${config.lib.stylix.colors.base07};
      }
      #workspaces button {
        color: #${config.lib.stylix.colors.base05};
        background: transparent;
        border-bottom: 3px solid transparent;
      }
      #workspaces button.active {
        color: #${config.lib.stylix.colors.base0B};
        border-bottom: 3px solid #${config.lib.stylix.colors.base0B};
      }
      #workspaces button.urgent {
        background: #${config.lib.stylix.colors.base08};
      }
      #custom-launcher, #clock, #cpu, #memory, #custom-powermenu, #tray {
        padding: 0 10px;
        color: #${config.lib.stylix.colors.base07};
      }
      #custom-sep {
        color: #${config.lib.stylix.colors.base03};
      }
      #clock {
        color: #${config.lib.stylix.colors.base0A};
        border-bottom: 3px solid #${config.lib.stylix.colors.base0A};
      }
      #cpu {
        color: #${config.lib.stylix.colors.base0B};
        border-bottom: 3px solid #${config.lib.stylix.colors.base0B};
      }
      #memory {
        color: #${config.lib.stylix.colors.base0E};
        border-bottom: 3px solid #${config.lib.stylix.colors.base0E};
      }
    '';
  };

  home.file.".config/hypr" = {
    source = ./config/hypr;
    force = true;
  };

  home.file.".config/foot" = {
    source = ./config/foot;
    force = true;
  };
}