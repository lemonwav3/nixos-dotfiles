{ config, lib, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    # Code editors
    vim 
    neovim

    # Terminal emulators
    foot
    kitty 

    # File explorers
    kdePackages.dolphin
    
    # Application launchers
    wofi

    # Music players
    rmpc
    
    # Browsers
    librewolf

    # System utils 
    btop # system monitor
    dysk # storage monitor
    git
    hyprpaper
    grim # Screenshots?
    slurp # Screenshots
    wl-clipboard
    fastfetch
    pkgs.zapzap
    localsend
    ytdownloader
    wget
    qbittorrent

    # System-wide cursor theme for the Wayland SDDM greeter (Weston only draws
    # a pointer if the theme exists in its XCURSOR_PATH).
    bibata-cursors
  ];
}
