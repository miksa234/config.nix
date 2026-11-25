{ config, ... }:
{
  dendritic.modules.nixos.networkmanager =
    { ... }:
    {
      imports = [
        config.dendritic.modules.nixos.networkmanager-secrets
        config.dendritic.modules.nixos.networkmanager-dispatcher
      ];

      networking.firewall.enable = false;
      networking.networkmanager.enable = true;
      networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];
    };
}
