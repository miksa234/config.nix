{ config, inputs, ... }:
let
  data = config.dendritic.data;
in
{
  dendritic.modules.home.niri =
    {
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.niri.homeModules.niri
        config.dendritic.modules.home.niri-monitor-services
      ];

      config = lib.mkIf (!pkgs.stdenv.hostPlatform.isDarwin) {
        programs.niri = {
          enable = true;
          package = pkgs.niri;
          settings = {
            prefer-no-csd = true;
            screenshot-path = "~/screenshot_%Y-%m-%dT%H-%M-%S.png";
            hotkey-overlay.skip-at-startup = true;
            window-rules = data.niriRules;
            layer-rules = data.niriLayerRules;
            workspaces = data.niriWorkspaces;
            binds = data.niriNavigationBinds;
            layout = data.niriLayout;
            cursor = data.niriCursor;
            xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
            outputs = data.niriOutputs;
            input = data.niriInput;
          };
        };
      };
    };

  dendritic.modules.home.niri-desktop = { lib, pkgs, ... }: {
    imports = [ config.dendritic.modules.home.niri ];
    config = lib.mkIf (!pkgs.stdenv.hostPlatform.isDarwin) {
      programs.niri.settings = {
        binds = data.niriAppBinds { inherit lib pkgs; };
        spawn-at-startup = data.niriAutostart { inherit lib pkgs; };
      };
    };
  };
}
