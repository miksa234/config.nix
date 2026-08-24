{ ... }:
{
  dendritic.data.niriAutostart =
    { lib, pkgs }:
    [
      { command = [ "background" ]; }
      { command = [ "check-mail" ]; }
      {
        command = [
          "dbus-update-activation-environment"
          "--systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=niri"
        ];
      }
      {
        command = [
          "systemctl"
          " --user"
          "import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=niri"
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
          "${lib.getExe pkgs.swayidle}"
          "-w"
          "timeout"
          "300"
          "swaylock -f -c 000000"
          "timeout"
          "3600"
          "systemctl suspend-then-hibernate"
        ];
      }
    ];
}
