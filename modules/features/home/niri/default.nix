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
      ];

      config = lib.mkIf (!pkgs.stdenv.hostPlatform.isDarwin) {
        programs.niri = {
          enable = true;
          package = pkgs.niri;
          settings = {
            prefer-no-csd = true;
            hotkey-overlay.skip-at-startup = true;
            overview.backdrop-color = "#000000";

            window-rules = data.niriRules;
            layer-rules = data.niriLayerRules;
            workspaces = data.niriWorkspaces;
            binds = data.niriBinds { inherit lib pkgs; };
            layout = data.niriLayout;
            cursor = data.niriCursor;
            xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
            spawn-at-startup = data.niriAutostart { inherit lib pkgs; };
            outputs = data.niriOutputs;
            input = data.niriInput;
          };
        };
      };
    };
}
