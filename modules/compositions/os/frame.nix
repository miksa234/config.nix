{ config, ... }:
let
  modules = config.dendritic.modules.nixos;
in
{
  dendritic.configurations.nixos.frame = {
    system = "x86_64-linux";
    module = {
      imports = [
        modules.frame
        modules.nix-settings
        modules.networkmanager
        modules.home-manager
        modules.mika
        modules.root
      ];
      networking.hostName = "frame";
      home-manager.users.mika.imports = [
        config.dendritic.modules.home.mika-profile
      ];
    };
  };
}
