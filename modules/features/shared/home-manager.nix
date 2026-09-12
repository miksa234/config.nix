{ inputs, ... }:
let
  common = { pkgs, ... }: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      extraSpecialArgs = {
        inherit inputs;
        inherit (pkgs.stdenv) hostPlatform;
      };
    };
  };
in
{
  dendritic.modules.nixos.home-manager = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
      common
    ];
  };

  dendritic.modules.darwin.home-manager = {
    imports = [
      inputs.home-manager.darwinModules.home-manager
      common
    ];
  };
}
