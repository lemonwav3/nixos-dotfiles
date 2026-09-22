{ config, lib, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the LightDM display manager and log into Hyprland.
  # services.xserver.displayManager.lightdm.enable = true;
  # services.displayManager.defaultSession = "hyprland";

  # SDDM. The X11 greeter is a no-go on this hybrid AMD/NVIDIA laptop
  # (no /dev/dri/card0 for the AMD iGPU when the amdgpu firmware glitches, and
  # no NVIDIA Xorg config -> "no screens found", black screen), so use the
  # Wayland greeter (Weston) and give it a cursor theme to draw.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    # kwin renders the greeter's pointer reliably; weston's kiosk shell does
    # not honour the XCURSOR_* env fallback, so its cursor never appears.
    wayland.compositor = "kwin";
    settings = {
      General = {
        # Qt greeter: draw its own pointer on the Wayland backend. Comma-separated
        # KEY=VALUE pairs, per the SDDM config format. layer-shell is required by
        # the kwin compositor and must be kept alongside the XCURSOR overrides.
        GreeterEnvironment = "QT_WAYLAND_SHELL_INTEGRATION=layer-shell,XCURSOR_THEME=Bibata-Modern-Ice,XCURSOR_SIZE=24,XCURSOR_PATH=/run/current-system/sw/share/icons";
      };
      Theme = {
        CursorTheme = "Bibata-Modern-Ice";
        CursorSize = 24;
      };
    };
  };
  services.displayManager.defaultSession = "hyprland";

  # Weston only renders a pointer if it can load an xcursor theme; it falls back
  # to XCURSOR_* env vars, so point the whole display-manager stack
  # (SDDM daemon -> Weston greeter) at the system cursor theme.
  systemd.services.display-manager.environment = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
    XCURSOR_PATH = "/run/current-system/sw/share/icons";
  };

  # Qylock lockscreen themes (installs the SDDM greeter + qylock-lock wrapper).
  programs.qylock = {
    enable = true;
    theme = "pixel-hollowknight";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;
}
