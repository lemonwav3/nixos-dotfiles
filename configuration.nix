{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/system/styling.nix
      ./modules/system/system.nix
      ./modules/system/productivity.nix
      ./modules/system/gaming.nix
    ];
  # --- BOOT ---
  # Use the systemd-boot EFI boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #zram swap: guards rebuilds/compilation against OOM (no disk swap currently)
  zramSwap.enable = true;
  # 
  
  # --- NETWORKING ---
  networking.hostName = "nixos-machine"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  # 

  # --- DISPLAY ---
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };
  # Enable the X11 windowing system
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
  #

  # --- POWER ---
  # Power profiles: power-saver / balanced / performance (cycled from waybar).
  services.power-profiles-daemon.enable = true;
  # Acer battery health control (80% charge limit). Out-of-tree WMI driver.
  boot.extraModulePackages = [
    (config.boot.kernelPackages.callPackage ./pkgs/acer-wmi-battery.nix { })
  ];
  boot.kernelModules = [ "acer-wmi-battery" ];
  # Start with the 80% charge limit enabled so the battery does not sit at 100%
  # while plugged in.
  environment.etc."modprobe.d/acer-wmi-battery.conf".text = ''
    options acer-wmi-battery enable_health_mode=1
  '';
  # The health_mode sysfs attribute is a driver attr owned by root; make it
  # user-writable so the waybar powercap button works without sudo.
  systemd.services.acer-wmi-battery-perms = {
    description = "Allow the user to toggle the Acer battery charge limit";
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-modules-load.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = ''
        ${pkgs.coreutils}/bin/chmod a+rw \
          /sys/bus/wmi/drivers/acer-wmi-battery/health_mode \
          /sys/bus/wmi/drivers/acer-wmi-battery/calibration_mode
      '';
    };
  };
  #

  # --- SERVICES ---
  # Printing with CUPS
  services.printing.enable = true;
  # Sound with pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # Use the WirePlumber session manager
    #wireplumber.enable = true;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  services.blueman.enable = true;
  #
  
  # --- USERS ---
  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users."tali" = {
    isNormalUser = true;
    description = "T";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  #

  # --- LOCALE ---
  # Set your time zone.
  time.timeZone = "Europe/Madrid";
  # Select internationalisation
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };
  # Keymaps
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "es";
    variant = "winkeys";
  };
  # Configure console keymap
  console.keyMap = "es";
  # 

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install firefox
  programs.firefox.enable = true;
  programs.steam.enable = true;
  programs.gamescope.enable = true;

  system.stateVersion = "26.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
