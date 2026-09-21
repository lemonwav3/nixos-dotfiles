{ config, lib, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    # Code editors
    vim 
    neovim

    # Terminal emulators
    kitty 
    foot

    # File explorers
    kdePackages.dolphin
    
    # Application launchers
    rofi
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

    # System-wide cursor theme for the Wayland SDDM greeter (Weston only draws
    # a pointer if the theme exists in its XCURSOR_PATH).
    bibata-cursors
  ];
}
