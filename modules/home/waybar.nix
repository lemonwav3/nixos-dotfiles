{ config, lib, pkgs, ... }:

{
  options.my.waybar.center = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    description = "Launcher modules shown in the centre of waybar.";
  };



  config.programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (old: {
      patches = (old.patches or []) ++ [ ../../patches/waybar-lua-dispatch.patch ];
    });
    settings = [
      {
      layer = "top";
      position = "top";
      height = 30;
      spacing = 4;
      modules-left = [
        "custom/logo"
        "custom/sep"
        "battery"
        "custom/sep"
        "backlight"
        "custom/sep"
        "pulseaudio"
        "custom/sep"
        "hyprland/workspaces"
      ];
      modules-center = config.my.waybar.center;
      modules-right = [
        "tray"
	"custom/sep"
        "power-profiles-daemon"
        "custom/sep"
        "custom/powercap"
        "custom/sep"
        "network"
        "custom/sep"
        "clock"
      ];
      "custom/logo" = {
        format = " ";
        on-click = "wlogout";
      };
      "custom/sep" = {
        format = "|";
        interval = 0;
      };
      tray = { spacing = 8; };
      "power-profiles-daemon" = {
        format = "{icon}";
        "format-icons" = {
          default = " ";
          power-saver = " ";
          balanced = " ";
          performance = " ";
        };
        tooltip = false;
      };
      "custom/powercap" = {
        exec = ''
          p=/sys/bus/wmi/drivers/acer-wmi-battery/health_mode
          v="$(cat "$p" 2>/dev/null)"
          if [ "$v" = "1" ]; then
            printf " \uf1e6 "
          else
            printf " \uf240 "
          fi
        '';
        on-click = ''
          p=/sys/bus/wmi/drivers/acer-wmi-battery/health_mode
          v="$(cat "$p" 2>/dev/null)"
          if [ "$v" = "1" ]; then
            echo 0 > "$p"
          else
            echo 1 > "$p"
          fi
        '';
        interval = 5;
        tooltip = false;
      };
      "custom/librewolf" = {
        format = " ";
        on-click = "librewolf";
      };
      "custom/thunderbird" = {
        format = " ";
        on-click = "thunderbird";
      };
      "custom/obsidian" = {
        format = " ";
        on-click = "obsidian";
      };
      "custom/krita" = {
        format = " ";
        on-click = "krita";
      };
      "custom/steam" = {
        format = " ";
        on-click = "steam";
      };
      "custom/lutris" = {
        format = "󰊖";
        on-click = "lutris";
      };
      "custom/vesktop" = {
        format = "";
        on-click = "vesktop";
      };
      battery = {
        format = "{icon} {capacity}%";
        format-charging = "  {capacity}%";
        format-plugged = "  {capacity}%";
        format-icons = [ " " " " " " " " " " ];
      };
      backlight = {
        format = "   {percent}% ";
        "on-scroll-up" = "brightnessctl set 1%+";
        "on-scroll-down" = "brightnessctl set 1%-";
      };
      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = " MUTE";
        format-icons = {
          default = [ " " " " ];
        };
        "on-click" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "on-scroll-up" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+";
        "on-scroll-down" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-";
      };
      "hyprland/workspaces" = {
        format = "{name}";
      };
      network = {
        format = "Online";
        format-disconnected = "Disconnected";
      };
      clock = {
        format = "{:%a %d %b %H:%M}";
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
      #custom-logo, #battery, #backlight, #pulseaudio, #network, #clock {
        padding: 0 10px;
        color: #${config.lib.stylix.colors.base07};
      }
      #custom-sep {
        color: #${config.lib.stylix.colors.base03};
      }
      #custom-librewolf, #custom-thunderbird, #custom-obsidian, #custom-krita, #custom-steam {
        padding: 0 12px;
        color: #${config.lib.stylix.colors.base07};
        font-size: 18px;
      }
      #custom-librewolf:hover, #custom-thunderbird:hover, #custom-obsidian:hover, #custom-krita:hover, #custom-steam:hover {
        color: #${config.lib.stylix.colors.base0A};
      }
      #custom-logo {
        color: #${config.lib.stylix.colors.base0A};
        border-bottom: 3px solid #${config.lib.stylix.colors.base0A};
      }
      #battery {
        color: #${config.lib.stylix.colors.base0C};
        border-bottom: 3px solid #${config.lib.stylix.colors.base0C};
      }
      #battery.warning {
        color: #${config.lib.stylix.colors.base0A};
        border-bottom: 3px solid #${config.lib.stylix.colors.base0A};
      }
      #battery.critical {
        color: #${config.lib.stylix.colors.base08};
        border-bottom: 3px solid #${config.lib.stylix.colors.base08};
      }
      #backlight {
        color: #${config.lib.stylix.colors.base0A};
        border-bottom: 3px solid #${config.lib.stylix.colors.base0A};
      }
      #pulseaudio {
        color: #${config.lib.stylix.colors.base0B};
        border-bottom: 3px solid #${config.lib.stylix.colors.base0B};
      }
      #pulseaudio.muted {
        color: #${config.lib.stylix.colors.base08};
      }
      #network {
        color: #${config.lib.stylix.colors.base0D};
        border-bottom: 3px solid #${config.lib.stylix.colors.base0D};
      }
      #network.disconnected {
        background: #${config.lib.stylix.colors.base08};
      }
      #clock {
        color: #${config.lib.stylix.colors.base0A};
        border-bottom: 3px solid #${config.lib.stylix.colors.base0A};
      }
    '';
  };
}
