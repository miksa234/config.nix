{ config, lib, ... }:
let
  modules = config.dendritic.modules.darwin;
in
{
  dendritic.configurations.darwin.mac = {
    system = "aarch64-darwin";
    module = {
      imports = [
        modules.mac
        modules.nix-settings
        modules.home-manager
        modules.mika
        modules.root
      ];
      networking.hostName = "mac";
      home-manager.users.mika.imports = [
        config.dendritic.modules.home.mika-profile
        {
          home = {
            homeDirectory = lib.mkForce "/Users/mika";
          };
        }
      ];
    };
  };
}
