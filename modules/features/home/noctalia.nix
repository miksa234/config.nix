{ inputs, ... }:
{
  dendritic.modules.home.noctalia =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      config = lib.mkIf (!pkgs.stdenv.hostPlatform.isDarwin) {

        programs.noctalia = {
          enable = true;
          systemd.enable = true;
          package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;

          customPalettes.palette = {
            dark = {
              mPrimary = "#F5F5F7";
              mOnPrimary = "#000000";
              mSecondary = "#0A84FF";
              mOnSecondary = "#FFFFFF";
              mTertiary = "#FFC87F";
              mOnTertiary = "#000000";
              mError = "#FF4D4D";
              mOnError = "#000000";
              mSurface = "#000000";
              mOnSurface = "#F5F5F7";
              mSurfaceVariant = "#1C1C1E";
              mOnSurfaceVariant = "#AEAEB2";
              mOutline = "#48484A";
              mShadow = "#000000";
              mHover = "#262626";
              mOnHover = "#F5F5F7";
              terminal = { };
            };
            light = {
              mPrimary = "#1D1D1F";
              mOnPrimary = "#FFFFFF";
              mSecondary = "#0A84FF";
              mOnSecondary = "#FFFFFF";
              mTertiary = "#AF6E00";
              mOnTertiary = "#FFFFFF";
              mError = "#D70015";
              mOnError = "#FFFFFF";
              mSurface = "#F5F5F7";
              mOnSurface = "#1D1D1F";
              mSurfaceVariant = "#E5E5EA";
              mOnSurfaceVariant = "#6E6E73";
              mOutline = "#C7C7CC";
              mShadow = "#8E8E93";
              mHover = "#E5E5EA";
              mOnHover = "#1D1D1F";
              terminal = { };
            };
          };

          settings = {
            theme = {
              mode = "dark";
              source = "custom";
              custom_palette = "palette";
              pure_black_dark = true;
            };

            shell = {
              corner_radius_scale = 0;
              font_family = "Terminus";
              popup_shadows = false;
              launch_apps_as_systemd_services = true;
              clipboard_enabled = false;
              keyboard_layout.custom_labels = {
                "English (US)" = "US";
                "German" = "DE";
              };
            };

            osd.kinds.privacy = true;
            accessibility.ui_scale = 1.0;
            dock.enabled = false;
            backdrop.enabled = true;
            location.auto_locate = true;

            wallpaper = {
              enabled = true;
              directory = "${config.xdg.dataHome}/wallpaper";
              transition = [ ];
              transition_duration = 0;
            };

            bar = {
              order = [ "main" ];
              main = {
                position = "top";
                background_opacity = 0;
                padding = 10;
                widget_spacing = 12;
                radius = 0;
                capsule_radius = 0;
                capsule = false;
                shadow = false;
                font_family = "Terminus";
                scale = 1;
                margin_ends = 0;

                start = [ "workspaces" ];
                center = [ ];
                end = [
                  "notifications"
                  "battery"
                  "bluetooth"
                  "volume"
                  "keyboard_layout"
                  "network"
                  "cpu"
                  "temp"
                  "ram"
                  "clock"
                ];
              };
            };

            lockscreen = {
              enabled = true;
              fingerprint = true;
              transition = [ ];
            };

            lockscreen_widgets = {
              enabled = true;
              widget_order = [ "lockscreen-login-box@eDP-1" ];
              widget."lockscreen-login-box@eDP-1" = {
                type = "login_box";
                output = "eDP-1";
                box_width = 400.0;
                box_height = 70.0;
                cx = 752.0;
                cy = 501.0;
                settings = {
                  center_password_text = true;
                  layout = "compact";
                  show_caps_lock = true;
                  show_keyboard_layout = false;
                  show_login_button = false;
                  show_unlock_hint = false;
                };
              };
            };

            widget = {
              workspaces = {
                show_labels = true;
                label_source = "id";
                max_label_chars = 2;
                focused_output_only = true;
                focused_color = "primary";
                occupied_color = "secondary";
                empty_color = "on_primary";
                scale = 1.2;
              };

              active_window = {
                display = "icon_and_text";
                max_length = 500;
                title_scroll = "on_hover";
              };

              keyboard_layout = {
                display = "short";
                show_glyph = true;
                show_label = true;
                hide_when_single_layout = false;
              };

              network = {
                vpn_status = "replace";
                show_label = true;
                show_vpn_label = true;
              };

              cpu = {
                type = "sysmon";
                stat = "cpu_usage";
                visualization = "gauge";
              };
              temp = {
                type = "sysmon";
                stat = "cpu_temp";
              };
              ram = {
                type = "sysmon";
                stat = "ram_used";
              };

              clock.format = "{:%H:%M:%S}";
            };
          };
        };
      };
    };
}
