{ inputs, ... }:
{
  dendritic.modules.darwin.rift =
    { lib, pkgs, ... }:
    {
      imports = [ inputs.rift.darwinModules.rift ];
      services.rift = {
        enable = true;
        serviceConfig = {
          EnvironmentVariables = {
            HOME = "/Users/mika";
            SHELL = lib.getExe pkgs.zsh;
          };
          StandardOutPath = "/tmp/rift.log";
          StandardErrorPath = "/tmp/rift.error.log";
        };
        launchPrefix = [
          (lib.getExe pkgs.zsh)
          "-c"
          ''source "$HOME/.zshenv"; exec "$@"''
          "--"
        ];
        config = {
          settings = {
            default_disable = false;
            animate = true;
            animation_duration = 0.05;
            animation_fps = 100.0;
            focus_follows_mouse = true;
            mouse_follows_focus = true;
            mouse_hides_on_focus = true;
            hot_reload = true;
            layout = {
              mode = "scrolling";
              scrolling = {
                column_width_ratio = 0.7;
                min_column_width_ratio = 0.3;
                max_column_width_ratio = 0.9;
                alignment = "center";
                focus_navigation_style = "niri";
              };
              gaps = {
                outer = {
                  top = 10;
                  left = 10;
                  bottom = 10;
                  right = 10;
                };
                inner = {
                  horizontal = 10;
                  vertical = 10;
                };
              };
            };
            ui = {
              mission_control.enabled = true;
              menu_bar = {
                enabled = true;
                show_empty = true;
                mode = "all";
                active_label = "name";
                display_style = "label";
              };
            };
          };

          virtual_workspaces = {
            enabled = true;
            default_workspace_count = 5;
            auto_assign_windows = true;
            preserve_focus_per_workspace = true;
            workspace_auto_back_and_forth = true;
            workspace_names = [
              "1"
              "2"
              "3"
              "4"
              "5"
            ];
          };

          keys = {
            "Alt + Enter".exec = [
              "open"
              "-na"
              "Ghostty"
            ];
            "Alt + C".exec = [
              "open"
              "-na"
              "Firefox"
            ];
            "Alt + D".exec = [ "dmenu-mac_run" ];
            "Alt + W".exec = [
              "open"
              "-na"
              "Spotify"
            ];
            "Alt + V".exec = [ "dmenu-mac-clipboard" ];
            "Alt + Shift + V".exec = [ "dmenu-mac-clipboard-clear" ];
            "Alt + P".exec = [ "passmenu-otp" ];
            "Alt + M".exec = [
              "open"
              "-na"
              "Ghostty"
              "--args"
              "-e"
              "neomutt"
            ];
            "Alt + S".exec = [
              "sh"
              "-c"
              ''screencapture "$HOME/Pictures/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"''
            ];
            "Alt + Shift + S".exec = [
              "sh"
              "-c"
              ''screencapture -i "$HOME/Pictures/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"''
            ];
            "Alt + K".move_focus = "right";
            "Alt + J".move_focus = "left";
            "Meta + K" = "prev_workspace";
            "Meta + J" = "next_workspace";
            "Alt + H".focus_display = "left";
            "Alt + L".focus_display = "right";

            "Alt + Shift + K".move_node = "right";
            "Alt + Shift + J".move_node = "left";
            "Meta + Shift + K" = {
              move_window_to_workspace = {
                workspace = "prev";
                follow = true;
              };
            };
            "Meta + Shift + J" = {
              move_window_to_workspace = {
                workspace = "next";
                follow = true;
              };
            };
            "Alt + Shift + H".move_window_to_display.selector = "left";
            "Alt + Shift + L".move_window_to_display.selector = "right";

            "Alt + 1".switch_to_workspace = 0;
            "Alt + 2".switch_to_workspace = 1;
            "Alt + 3".switch_to_workspace = 2;
            "Alt + 4".switch_to_workspace = 3;
            "Alt + 5".switch_to_workspace = 4;

            "Alt + Shift + 1".move_window_to_workspace = 0;
            "Alt + Shift + 2".move_window_to_workspace = 1;
            "Alt + Shift + 3".move_window_to_workspace = 2;
            "Alt + Shift + 4".move_window_to_workspace = 3;
            "Alt + Shift + 5".move_window_to_workspace = 4;

            "Alt + Tab" = "show_mission_control_all";
            "Alt + F" = "toggle_fullscreen_within_gaps";
            "Alt + G" = "toggle_fullscreen";
            "Alt + Shift + F" = "toggle_window_floating";
            "Alt + BracketLeft".consume_or_expel_window = "left";
            "Alt + BracketRight".consume_or_expel_window = "right";
            "Alt + Ctrl + H".resize_window_shrink = "horizontal";
            "Alt + Ctrl + L".resize_window_grow = "horizontal";
            "Alt + Ctrl + K".resize_window_shrink = "vertical";
            "Alt + Ctrl + J".resize_window_grow = "vertical";

            "Meta + Comma" = "toggle_stack";
            "Meta + Slash" = "toggle_orientation";
            "Meta + Tab" = "switch_to_last_workspace";
            "Alt + Shift + Q" = "close_window";
          };
        };
      };
    };
}
