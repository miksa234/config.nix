{ ... }:
{
  dendritic.modules.home.systemd-services =
    { pkgs, lib, ... }:
    lib.mkIf (!pkgs.stdenv.hostPlatform.isDarwin) {
      systemd.user = {
        startServices = "sd-switch";
        services.mbsync = {
          Unit = {
            Description = "Mailbox sync service";
            RefuseManualStart = "no";
            RefuseManualStop = "yes";
          };
          Service = {
            Type = "oneshot";
            ExecStart = "${pkgs.zsh}/bin/zsh -c 'mbsync -c .config/isync/mbsyncrc -a -q && ${pkgs.notmuch}/bin/notmuch new'";
          };
          Install.wantedBy = [ "default.target" ];
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
        timers.mbsync = {
          Unit = {
            Description = "Mailbox sync timer";
            RefuseManualStop = "no";
            RefuseManualStart = "no";
            ConditionACPower = true;
          };
          Timer = {
            Persistent = false;
            OnBootSec = "0.3m";
            OnUnitActiveSec = "0.5m";
            Unit = "mbsync.service";
          };
          Install.WantedBy = [ "timers.target" ];
        };
        services.niri-wakeup-monitors = {
          Unit = {
            Description = "Wake up external monitors after resume (niri)";
            After = [
              "suspend.target"
              "hibernate.target"
              "systemd-suspend-then-hibernate.target"
            ];
          };

          Service = {
            Type = "oneshot";
            ExecStart = "${pkgs.zsh}/bin/zsh -c 'niri-wakeup-monitors'";
          };

          Install.WantedBy = [
            "suspend.target"
            "hibernate.target"
            "systemd-suspend-then-hibernate.target"
          ];
        };
        services.niri-monitors = {
          Unit = {
            Description = "Manage niri monitor topology (single instance)";
            After = [ "niri.service" ];
            PartOf = [ "graphical-session.target" ];
          };

          Service = {
            Type = "simple";
            ExecStart = "${pkgs.zsh}/bin/zsh -c 'niri-monitors'";
            Restart = "on-failure";
            RestartSec = "5";
          };

          Install.WantedBy = [ "graphical-session.target" ];
        };
      };
    };
}
