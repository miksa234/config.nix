{
  dendritic.modules.nixos.frame =
    { pkgs, ... }:
    {
      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };

        kernelPackages = pkgs.linuxPackages_latest;
        kernelModules = [ "kvm-amd" ];
        kernelParams = [
          "loglevel=3"
          "nowatchdog"
          "migrations=auto"
          "amd_iommu=on"
          "iommu=pt"
          "rtc_cmos.use_acpi_alarm=1"
          "usbcore.autosuspend=-1"
          "pcie_port_pm=off"
          "acpi.no_ec_wakup=1"
          "nvme_core.default_ps_states=1"
          "amdgpu.dcfeaturemask=0x2"
        ];

        supportedFilesystems = [
          "btrfs"
          "ext4"
          "vfat"
          "ntfs"
        ];

        initrd = {
          availableKernelModules = [
            "nvme"
            "xhci_pci"
            "thunderbolt"
            "usbhid"
            "usb_storage"
          ];
          kernelModules = [
            "dm-snapshot"
            "cryptd"
          ];
          luks.devices."cryptroot".device = "/dev/disk/by-uuid/68d936fb-68be-4351-a557-874ef2d96efc";
        };

      };
    };
}
