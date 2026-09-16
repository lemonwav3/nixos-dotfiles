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

    # GStreamer stack: video backgrounds for the qylock (quickshell + SDDM) themes.
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
  ];
}
