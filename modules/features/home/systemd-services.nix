{ config, ... }:
let
  monitors = config.dendritic.data.niriMonitors;
in
{
  dendritic.modules.home.systemd-services =
    { pkgs, lib, ... }:
    let
      powerProfileManager = pkgs.writeShellApplication {
        name = "power-profile-on-ac";
        runtimeInputs = [
          pkgs.coreutils
          pkgs.power-profiles-daemon
        ];
        text = ''
          last_profile=""
          while true; do
            profile=balanced
            if [[ $(cat /sys/class/power_supply/ACAD/online 2>/dev/null || echo 0) == 1 ]]; then
              profile=performance
            fi
            if [[ "$profile" != "$last_profile" ]] && /run/wrappers/bin/sudo -n powerprofilesctl set "$profile"; then
              last_profile="$profile"
            fi
            sleep 10
          done
        '';
      };
    in
    {
      config = lib.mkIf (!pkgs.stdenv.hostPlatform.isDarwin) {
        systemd.user = {
          startServices = "sd-switch";
          services.power-profile-on-ac = {
            Unit = {
              Description = "Use performance on AC and balanced on battery";
              PartOf = [ "graphical-session.target" ];
            };
            Service = {
              ExecStart = lib.getExe powerProfileManager;
              Restart = "on-failure";
              RestartSec = 5;
            };
            Install.WantedBy = [ "graphical-session.target" ];
          };
          services.cliphist = {
            Unit = {
              Description = "Wayland clipboard history";
              PartOf = [ "graphical-session.target" ];
              After = [ "graphical-session.target" ];
            };
            Service = {
              ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store";
              Restart = "on-failure";
              RestartSec = 1;
            };
            Install.WantedBy = [ "graphical-session.target" ];
          };
        };
      };
    };

  dendritic.modules.home.niri-monitor-services =
    { pkgs, lib, ... }:
    let
      monitorManager = pkgs.writeShellApplication {
        name = "niri-monitors";
        runtimeInputs = [
          pkgs.niri
          pkgs.jq
          pkgs.coreutils
          pkgs.util-linux
        ];
        text = ''
          exec 9>"''${XDG_RUNTIME_DIR:?}/niri-monitors.lock"
          flock -n 9 || exit 0
          candidate=""
          last_layout=""

          # Connector names change when docking; match the stable monitor IDs.
          connector() {
            jq -r --arg id "$1" '
              to_entries[] | select(
                (.value.make + " " + .value.model + " " + (.value.serial // "Unknown")) == $id
              ) | .key
            ' <<< "$outputs"
          }

          set_output() {
            local output="$1" state="$2" enabled
            [[ -n "$output" ]] || return 0
            enabled=$(jq -r --arg output "$output" '.[$output].current_mode != null' <<< "$outputs")
            if [[ ("$state" == on && "$enabled" == false) || ("$state" == off && "$enabled" == true) ]]; then
              niri msg output "$output" "$state"
            fi
          }

          move_workspaces() {
            local prefix="$1" output="$2" workspace
            for workspace in "$prefix"{1..5}; do
              niri msg action move-workspace-to-monitor --reference "$workspace" "$output" || return 1
              niri msg action move-workspace-to-index --reference "$workspace" "''${workspace:1}" || return 1
            done
          }

          apply_layout() {
            [[ -n "$left" || -n "$right" || -n "$laptop" ]] || return 1
            set_output "$left" on || return 1
            set_output "$right" on || return 1
            if [[ -n "$left" && -n "$right" ]]; then
              set_output "$laptop" off || return 1
            else
              set_output "$laptop" on || return 1
            fi

            if [[ "$layout" != "$last_layout" ]]; then
              move_workspaces l "''${left:-''${laptop:-$right}}" || return 1
              move_workspaces r "''${right:-''${laptop:-$left}}" || return 1
              last_layout="$layout"
              printf 'Monitor layout active: %s\n' "$layout"
            fi
          }

          # Two matching samples avoid reacting to half-connected docks.
          # Checking output state also restores the layout after resume or reload.
          while true; do
            if outputs=$(niri msg --json outputs); then
              left=$(connector "${monitors.left}")
              right=$(connector "${monitors.right}")
              laptop=$(connector "${monitors.laptop}")
              layout="$left|$right|$laptop"
              if [[ "$layout" == "$candidate" ]]; then
                apply_layout || true
              fi
              candidate="$layout"
            else
              candidate=""
            fi
            sleep 5
          done
        '';
      };
    in
    lib.mkIf (!pkgs.stdenv.hostPlatform.isDarwin) {
      home.packages = [ monitorManager ];
      systemd.user.services = {
        niri-monitors = {
          Unit = {
            Description = "Manage niri monitor topology (single instance)";
            After = [ "niri.service" ];
            PartOf = [ "graphical-session.target" ];
          };

          Service = {
            Type = "simple";
            ExecStart = lib.getExe monitorManager;
            Restart = "on-failure";
            RestartSec = "5";
          };

          Install.WantedBy = [ "graphical-session.target" ];
        };
      };
    };
}
