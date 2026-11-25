{ config, ... }:
let
  modules = config.dendritic.modules.home;
in
{
  dendritic.modules.home.r2d2-profile = {
    imports = [
      modules.r2d2
      modules.packages-system
      modules.packages-shell
      modules.packages-cli
      modules.packages-network
      modules.packages-development
      modules.nix-settings
    ];
  };

  dendritic.configurations.home.r2d2 = {
    system = "x86_64-linux";
    module = modules.r2d2-profile;
  };
}
