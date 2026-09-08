{ inputs, ... }:
{
  dendritic.modules.nixos.frame =
    {
      config,
      lib,
      modulesPath,
      pkgs,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
        inputs.nixos-hardware.nixosModules.framework-13-7040-amd
      ];

      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/adc85ee5-286c-44aa-9dfa-4580e59687dc";
          fsType = "ext4";
        };
        "/home" = {
          device = "/dev/disk/by-uuid/2e36575d-3dc4-4760-9bc1-9bf055371805";
          fsType = "ext4";
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/F656-048E";
          fsType = "vfat";
          options = [
            "fmask=0022"
            "dmask=0022"
          ];
        };
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/f1c0a91f-0460-4ba8-a414-f49c90dfa399"; }
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.enableAllFirmware = true;
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = false;
        package = inputs.nixpkgs-stable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.bluez;
      };
      hardware.sensor.iio.enable = false;
    };
}
