{ config, ... }:
let
  inherit (config.dendritic) modules;
in
{
  dendritic.modules.nixos.gaming = { pkgs, ... }: {
    users.groups.gaming = { };
    users.users.gaming = {
      isNormalUser = true;
      group = "gaming";
      extraGroups = [ ];
      home = "/home/gaming";
      homeMode = "0700";
      shell = pkgs.bashInteractive;
    };

    environment.etc."polkit-1/rules.d/00-gaming.rules".text = ''
      polkit.addRule(function(action, subject) {
        if (subject.user == "gaming") {
          if (action.id == "org.freedesktop.login1.chvt" && subject.local && subject.active) {
            return polkit.Result.YES;
          }
          return polkit.Result.NO;
        }
      });
    '';

    home-manager.users.gaming.imports = [ modules.home.gaming ];
  };

  dendritic.modules.home.gaming = { lib, pkgs, ... }: {
    imports = [
      modules.home.noctalia
      modules.home.niri
      modules.home.ghostty
      modules.home.dmenu-niri
      modules.home.theme
    ];

    home = {
      username = "gaming";
      homeDirectory = "/home/gaming";
      stateVersion = "26.05";
      packages = [
        (pkgs.lutris.override {
          steamSupport = false;
          extraPkgs = p: [
            p.wineWow64Packages.staging
            p.winetricks
          ];
        })
        pkgs.wineWow64Packages.staging
        pkgs.winetricks
        pkgs.pavucontrol
        pkgs.firefox
      ];
    };

    programs.bash.enable = true;
    programs.niri.settings = {
      spawn-at-startup = lib.mkForce [ ];
      binds = {
        "Mod+Return".action = lib.mkForce { spawn = lib.getExe pkgs.ghostty; };
        "Mod+D".action = lib.mkForce { spawn = "dmenu-niri_run"; };
        "Mod+C".action = lib.mkForce { spawn = lib.getExe pkgs.firefox; };
        "Mod+W".action = lib.mkForce { spawn = "lutris"; };
        "Mod+Shift+P".action = lib.mkForce { spawn = lib.getExe pkgs.pavucontrol; };
      };
    };

    systemd.user.startServices = "sd-switch";
    systemd.user.tmpfiles.rules = [
      "d %h/Games 0700 - - -"
      "d %h/Games/prefixes 0700 - - -"
    ];
  };
}
