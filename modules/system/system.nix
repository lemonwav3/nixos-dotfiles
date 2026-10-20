{ config, lib, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    # Code editors
    vim 
    neovim 

    # File explorers
    kdePackages.dolphin

    # Music players
    rmpc
    
    # Browsers
    librewolf

    # System utils 
    btop # system monitor
    dysk # storage monitor
    git
    grim # Screenshots?
    slurp # Screenshots
    wl-clipboard
    fastfetch
    pkgs.zapzap
    localsend
    ytdownloader
    wget
    qbittorrent
    unzip

    # System-wide cursor theme for the Wayland SDDM greeter (Weston only draws
    # a pointer if the theme exists in its XCURSOR_PATH).
    bibata-cursors
  ];
  services.clamav = {
    updater.enable = true;
  };
}
