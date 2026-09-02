{ inputs, ... }:
{
  dendritic.modules.home.noctalia =
    {
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

          settings = {
            theme = {
              mode = "dark";
              source = "builtin";
              builtin = "Ayu";
            };

            shell = {
              corner_radius_scale = 0;
              font_family = "Terminus";
              popup_shadows = false;
              launch_apps_as_systemd_services = true;
              clipboard_enabled = false;
            };

            osd.kinds.privacy = true;

            accessibility.ui_scale = 1.0;
            dock.enabled = false;
            wallpaper.enabled = false;
            location.auto_locate = true;

            bar = {
              order = [ "main" ];
              main = {
                position = "top";
                background_opacity = 0;
                padding = 10;
                widget_spacing = 20;
                radius = 0;
                capsule_radius = 0;
                capsule = false;
                shadow = false;
                font_family = "Terminus";
                font_weight = 700;
                scale = 1.2;
                margin_ends = 0;

                start = [ "workspaces" ];
                center = [ "active_window" ];
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

            widget = {
              workspaces = {
                capsule = true;
                capsule_opacity = 1.0;
                capsule_fill = "surface_variant";
                capsule_radius = 0;
                show_labels = true;
                label_source = "id";
                max_label_chars = 2;
                focused_output_only = true;
                focused_color = "#E6E6E6";
                empty_color = "on_primary";
                occupied_color = "primary";
              };

              active_window = {
                display = "icon_and_text";
                max_length = 500;
                title_scroll = "on_hover";
              };

              keyboard_layout = {
                display = "short";
                show_icon = true;
                show_label = true;
                hide_when_single_layout = false;
                custom_labels = {
                  "English (US)" = "US";
                  "German" = "DE";
                };
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
