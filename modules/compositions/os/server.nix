{ config, ... }:
let
  modules = config.dendritic.modules.nixos;
in
{
  dendritic.configurations.nixos.server = {
    system = "x86_64-linux";
    module = {
      imports = [
        modules.server
        modules.nix-settings
        modules.home-manager
        modules.r2d2
        modules.root
      ];
      networking.hostName = "server";
    };
  };
}
