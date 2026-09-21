{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/productivity.nix
      ./modules/rest.nix
      ./modules/system.nix
    ];

  # Add Stylix
  stylix.enable = true;
  stylix.autoEnable = true;
  stylix.polarity = "dark";
  stylix.opacity.terminal = 0.9;
  stylix.base16Scheme = import ./themes/gruvbox-dark-medium.nix;
  stylix.image = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/39/wallhaven-3911w9.jpg";
    sha256 = "sha256-dBmKkLR8yI1W7d9IRTOaErHf0KApSq0UsY5LWxAaSuA=";
  };
  stylix.fonts.monospace = {
    name = "JetBrainsMono Nerd Font";
    package = pkgs.nerd-fonts.jetbrains-mono;
  };
  stylix.cursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  # Fonts
  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-machine"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Power profiles: power-saver / balanced / performance (cycled from waybar).
  services.power-profiles-daemon.enable = true;

  # zram swap: guards rebuilds/compilation against OOM (no disk swap currently).
  zramSwap.enable = true;

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

  # Set your time zone.
  time.timeZone = "Europe/Madrid";


  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };


  # Select internationalisation properties.
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "es";
    variant = "winkeys";
  };

  # Configure console keymap
  console.keyMap = "es";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users."tali" = {
    isNormalUser = true;
    description = "T";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  programs.steam.enable = true;
  programs.gamescope.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

  # NixOS flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
