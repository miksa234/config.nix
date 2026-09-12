{ ... }:
{
  dendritic.data.niriAutostart =
    { lib, pkgs }:
    [
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
}
