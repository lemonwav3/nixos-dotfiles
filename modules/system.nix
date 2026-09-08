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
    waybar
    hyprpaper
    grim # Screenshots?
    slurp # Screenshots
    wl-clipboard
    fastfetch
  ];
}
