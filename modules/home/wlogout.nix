{ config, lib, pkgs, ... }:

{
  home.file.".config/wlogout/layout" = {
    text = ''
      {
        "label" : "lock",
        "action" : "loginctl lock-session",
        "text" : "",
        "keybind" : "l"
      }
      {
        "label" : "logout",
        "action" : "loginctl terminate-user $USER",
        "text" : "",
        "keybind" : "e"
      }
      {
        "label" : "suspend",
        "action" : "systemctl suspend",
        "text" : "",
        "keybind" : "u"
      }
      {
        "label" : "shutdown",
        "action" : "systemctl poweroff",
        "text" : "",
        "keybind" : "s"
      }
      {
        "label" : "reboot",
        "action" : "systemctl reboot",
        "text" : "",
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