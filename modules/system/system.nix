{ config, lib, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    # Code editors
    vim 
    neovim

    # Terminal emulators
    foot

    # File explorers
    kdePackages.dolphin
    
    # Application launchers
    wofi

    # Browsers
    librewolf

    # System utils 
    btop # system monitor
    dysk # storage monitor
    opencode # LLM frontend
    git
    hyprpaper
    grim # Screenshots?
    slurp # Screenshots
    wl-clipboard
    fastfetch
    pkgs.zapzap
    localsend
    ytdownloader

    # System-wide cursor theme for the Wayland SDDM greeter (Weston only draws
    # a pointer if the theme exists in its XCURSOR_PATH).
    bibata-cursors
  ];
}
