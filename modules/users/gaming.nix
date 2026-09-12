{ config, ... }:
let
  inherit (config.dendritic) modules;
in
{
  dendritic.modules.nixos.gaming = { pkgs, ... }: {
    users.groups.gaming = { };
    users.users.gaming = {
      isNormalUser = true;
      description = "Isolated gaming account";
      group = "gaming";
      extraGroups = [ ];
      home = "/home/gaming";
      homeMode = "0700";
      initialHashedPassword = "!";
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
        pkgs.fuzzel
        pkgs.pavucontrol
        pkgs.firefox
      ];
    };

    programs.bash.enable = true;
    programs.niri.settings.binds = {
      "Mod+Return".action.spawn = lib.getExe pkgs.ghostty;
      "Mod+D".action.spawn = lib.getExe pkgs.fuzzel;
      "Mod+C".action.spawn = lib.getExe pkgs.firefox;
      "Mod+W".action.spawn = "lutris";
      "Mod+Shift+P".action.spawn = lib.getExe pkgs.pavucontrol;
    };

    systemd.user.startServices = "sd-switch";
    systemd.user.tmpfiles.rules = [
      "d %h/Games 0700 - - -"
      "d %h/Games/prefixes 0700 - - -"
    ];
  };
}
