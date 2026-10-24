{ config, lib, pkgs, ... }:
{
  # Power profiles: power-saver / balanced / performance (cycled from waybar).
  services.power-profiles-daemon.enable = true;
  # Acer battery health control (80% charge limit). Out-of-tree WMI driver.
  boot.extraModulePackages = [
    (config.boot.kernelPackages.callPackage ../../pkgs/acer-wmi-battery.nix { })
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
  systemd.services = {
    systemd-suspend.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
    systemd-hibernate.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
    systemd-hybrid-sleep.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
    systemd-suspend-then-hibernate.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
  };
}
