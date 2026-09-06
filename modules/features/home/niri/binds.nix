{ ... }:
{
  dendritic.data.niriBinds =
    { lib, pkgs }:
    let
      terminalCmd = lib.getExe pkgs.ghostty;
      nic = "noctalia msg";
      clipboardMenu = lib.getExe (
        pkgs.writeShellApplication {
          name = "clipboard-menu";
          runtimeInputs = [
            pkgs.cliphist
            pkgs.wl-clipboard
          ];
          text = ''
            selection="$(cliphist list | dmenu-niri -p 'clipboard')" || exit 0
            test -n "$selection" || exit 0
            printf '%s' "$selection" | cliphist decode | wl-copy
          '';
        }
      );
      clearClipboardHistory = lib.getExe (
        pkgs.writeShellApplication {
          name = "clear-clipboard-history";
          runtimeInputs = [
            pkgs.cliphist
          ];
          text = ''
            choice="$(printf 'yes\nno\n' | dmenu-niri -p 'clear clipboard history?')" || exit 0
            test "$choice" = yes || exit 0
            cliphist wipe
          '';
        }
      );
    in
    {
      "Mod+Return".action.spawn = "${terminalCmd}";
      "Mod+C".action.spawn = "firefox";
      "Mod+D".action.spawn = "dmenu-niri_run";
      "Mod+P".action.spawn = "passmenu-otp";
      "Mod+B".action.spawn = "dmenu-bluetooth";
      "Mod+W".action.spawn-sh = "spotify & niri msg action focus-workspace r5";
      "Mod+Shift+P".action.spawn = "pavucontrol";
      "Mod+Shift+B".action.spawn = "nautilus";
      "Mod+Shift+W".action.spawn-sh = "${terminalCmd} -e nmtui";
      "Mod+M".action.spawn-sh = "TZ=Europe/Berlin ${terminalCmd} -e neomutt";
      "Mod+Shift+R".action.spawn-sh = "background";
      "Mod+V".action.spawn = clipboardMenu;
      "Mod+Shift+V".action.spawn = clearClipboardHistory;
      "Mod+Shift+Slash".action.show-hotkey-overlay = { };
      "Mod+Ctrl+Space".action.spawn-sh = "${nic} notification-clear-history";
      "Ctrl+Space".action.spawn-sh = "${nic} notification-clear-active";
      "Mod+Space".action.spawn-sh = "${nic} panel-toggle control-center";

      "Mod+Shift+E".action.quit.skip-confirmation = true;
      "Mod+Shift+Q".action.close-window = { };
      "Mod+F".action.maximize-column = { };
      "Mod+G".action.fullscreen-window = { };
      "Mod+Shift+F".action.toggle-window-floating = { };
      "Mod+Shift+C".action.center-column = { };
      "Mod+R".action.switch-preset-column-width = { };
      "Mod+BracketLeft".action.consume-window-into-column = { };
      "Mod+BracketRight".action.expel-window-from-column = { };

      "Mod+K".action.focus-column-right = { };
      "Mod+J".action.focus-column-left = { };
      "Alt+K".action.focus-workspace-up = { };
      "Alt+J".action.focus-workspace-down = { };

      "Mod+H".action.focus-monitor-left = { };
      "Mod+L".action.focus-monitor-right = { };

      "Mod+WheelScrollDown".action.focus-column-left = { };
      "Mod+WheelScrollUp".action.focus-column-right = { };
      "Alt+WheelScrollDown".action.focus-workspace-down = { };
      "Alt+WheelScrollUp".action.focus-workspace-up = { };

      "Mod+Shift+K".action.move-column-right = { };
      "Mod+Shift+J".action.move-column-left = { };
      "Alt+Shift+K".action.move-window-to-workspace-up = { };
      "Alt+Shift+J".action.move-window-to-workspace-down = { };

      "Mod+Shift+H".action.move-window-to-monitor-left = { };
      "Mod+Shift+L".action.move-window-to-monitor-right = { };
      "Mod+Tab".action.toggle-overview = { };

      "Mod+1".action.focus-workspace = "l1";
      "Mod+2".action.focus-workspace = "l2";
      "Mod+3".action.focus-workspace = "l3";
      "Mod+4".action.focus-workspace = "l4";
      "Mod+5".action.focus-workspace = "l5";

      "Alt+1".action.focus-workspace = "r1";
      "Alt+2".action.focus-workspace = "r2";
      "Alt+3".action.focus-workspace = "r3";
      "Alt+4".action.focus-workspace = "r4";
      "Alt+5".action.focus-workspace = "r5";

      "Mod+Shift+1".action.move-window-to-workspace = "l1";
      "Mod+Shift+2".action.move-window-to-workspace = "l2";
      "Mod+Shift+3".action.move-window-to-workspace = "l3";
      "Mod+Shift+4".action.move-window-to-workspace = "l4";
      "Mod+Shift+5".action.move-window-to-workspace = "l5";

      "Alt+Shift+1".action.move-window-to-workspace = "r1";
      "Alt+Shift+2".action.move-window-to-workspace = "r2";
      "Alt+Shift+3".action.move-window-to-workspace = "r3";
      "Alt+Shift+4".action.move-window-to-workspace = "r4";
      "Alt+Shift+5".action.move-window-to-workspace = "r5";

      "Mod+F1".action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      "Mod+F2".action.spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-";
      "Mod+F3".action.spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+";
      "Mod+F4".action.spawn-sh = "${nic} brightness-down";
      "Mod+F5".action.spawn-sh = "${nic} brightness-up";
      "Mod+Alt+L".action.spawn-sh = "swaylock -f -c 000000";

      "Mod+Ctrl+H".action.set-column-width = "-5%";
      "Mod+Ctrl+L".action.set-column-width = "+5%";
      "Mod+Ctrl+K".action.set-window-height = "-5%";
      "Mod+Ctrl+J".action.set-window-height = "+5%";

      "Alt+S".action.screenshot-screen = { };
      "Shift+Alt+S".action.screenshot = { };
      "Shift+Alt+W".action.screenshot-window = { };

      "Shift+Alt+V".action.spawn-sh =
        "${pkgs.wl-clipboard}/bin/wl-paste | ${lib.getExe pkgs.swappy} -f -";

    };
}
