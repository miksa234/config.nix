{ ... }:
{
  dendritic.modules.home.niri = { lib, pkgs, ... }: {
    programs.niri.settings.spawn-at-startup = [
      {
        command = [
          "dbus-update-activation-environment"
          "--systemd"
          "DISPLAY"
          "WAYLAND_DISPLAY"
          "XDG_CURRENT_DESKTOP=niri"
          "NIRI_SOCKET"
        ];
      }
      {
        command = [
          "nextcloud"
          "--background"
        ];
      }
      {
        command = [
          "noctalia"
          "msg"
          "wallpaper-random"
        ];
      }
      {
        command = [
          "${lib.getExe pkgs.swayidle}"
          "-w"
          "timeout"
          "300"
          "noctalia msg session lock"
          "timeout"
          "3600"
          "systemctl suspend-then-hibernate"
        ];
      }
    ];
  };
}
