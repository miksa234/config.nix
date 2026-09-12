{ config, inputs, ... }:
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

      programs.niri = {
        enable = true;
        package = pkgs.niri;
        settings = {
          prefer-no-csd = true;
          screenshot-path = "~/screenshot_%Y-%m-%dT%H-%M-%S.png";
          hotkey-overlay.skip-at-startup = true;
          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;
        };
      };
    };
}
