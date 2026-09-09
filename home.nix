{ config, lib, pkgs, ... }:

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

  home.packages = [ pkgs.wlogout pkgs.brightnessctl ];

  programs.waybar = {
    enable = true;
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
      modules-center = [ ];
      modules-right = [ "network" "custom/sep" "clock" ];
      "custom/logo" = {
        format = "  ";
        on-click = "wlogout";
      };
      "custom/sep" = {
        format = "|";
        interval = 0;
      };
      battery = {
        format = "{capacity}% {icon}";
        format-charging = "  {capacity}%";
        format-plugged = "  {capacity}%";
        format-icons = [ "" "" "" "" "" ];
      };
      backlight = {
        format = "  {percent}%";
        "on-scroll-up" = "brightnessctl set 1%+";
        "on-scroll-down" = "brightnessctl set 1%-";
      };
      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = " MUTE";
        format-icons = {
          default = [ "" "" ];
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

  home.file.".config/hypr" = {
    source = ./config/hypr;
    force = true;
  };

  programs.foot = {
    enable = true;
    settings.main = {
      font = lib.mkForce "JetBrainsMono Nerd Font:size=16";
      pad = "4x4";
      alpha = 0.9;
      "initial-color-theme" = "dark";
    };
  };

  home.file.".config/wlogout/layout" = {
    text = ''
      {
        "label" : "lock",
        "action" : "loginctl lock-session",
        "text" : "Lock",
        "keybind" : "l"
      }
      {
        "label" : "logout",
        "action" : "loginctl terminate-user $USER",
        "text" : "Logout",
        "keybind" : "e"
      }
      {
        "label" : "suspend",
        "action" : "systemctl suspend",
        "text" : "Suspend",
        "keybind" : "u"
      }
      {
        "label" : "shutdown",
        "action" : "systemctl poweroff",
        "text" : "Shutdown",
        "keybind" : "s"
      }
      {
        "label" : "reboot",
        "action" : "systemctl reboot",
        "text" : "Reboot",
        "keybind" : "r"
      }
    '';
  };
  home.file.".config/wlogout/style.css" = {
    text = ''
      * {
        background-image: none;
        box-shadow: none;
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 16px;
        font-weight: bold;
      }
      window {
        background-color: rgba(40, 40, 40, 0.9);
      }
      button {
        border-radius: 0;
        border-color: #${config.lib.stylix.colors.base03};
        text-decoration-color: #${config.lib.stylix.colors.base07};
        color: #${config.lib.stylix.colors.base07};
        background-color: #${config.lib.stylix.colors.base01};
        border-style: solid;
        border-width: 1px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 40%;
        padding: 32px;
      }
      button:focus, button:active, button:hover {
        color: #${config.lib.stylix.colors.base00};
        outline-style: none;
      }
      #lock { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png")); }
      #lock:hover { background-color: #${config.lib.stylix.colors.base0D}; }
      #logout { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png")); }
      #logout:hover { background-color: #${config.lib.stylix.colors.base0C}; }
      #suspend { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png")); }
      #suspend:hover { background-color: #${config.lib.stylix.colors.base0A}; }
      #shutdown { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png")); }
      #shutdown:hover { background-color: #${config.lib.stylix.colors.base08}; }
      #reboot { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png")); }
      #reboot:hover { background-color: #${config.lib.stylix.colors.base09}; }
    '';
  };
}
