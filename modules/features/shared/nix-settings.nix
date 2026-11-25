{ ... }:
let
  nixSettingsModule =
    {
      config,
      pkgs,
      lib,
      osConfig ? null,
      ...
    }:
    let
      isHomeManager = config ? home;
      isSystemManagedHome = isHomeManager && osConfig != null;
    in
    {
      nix = {
        enable = true;
        gc = {
          automatic = true;
          options = "--delete-older-than 30d";
        };
        settings = {
          use-xdg-base-directories = true;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          trusted-users = [
            "mika"
            "root"
          ];
        };
      }
      // lib.optionalAttrs (!isSystemManagedHome) {
        package = pkgs.nix;
      }
      // lib.optionalAttrs (!isHomeManager) {
        channel.enable = false;
        optimise.automatic = true;
      };
    };
in
{
  dendritic.modules.home.nix-settings = nixSettingsModule;
  dendritic.modules.nixos.nix-settings = nixSettingsModule;
  dendritic.modules.darwin.nix-settings = nixSettingsModule;
}
