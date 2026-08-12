{ inputs, ... }:
{
  dendritic.modules.nixos.frame =
    {
      lib,
      pkgs,
      ...
    }:
    {
      system.stateVersion = "26.05";

      virtualisation.vmVariant = {
        virtualisation = {
          diskSize = 50 * 1028;
          memorySize = 16 * 1028;
          cores = 6;
          resolution = {
            x = 1600;
            y = 900;
          };
          qemu.options = [
            "-enable-kvm"
            "-cpu host"
            "-display gtk,zoom-to-fit=false"
            "-vga virtio"
          ];
        };
      };

      virtualisation.docker = {
        enable = true;
        enableOnBoot = false;
      };

      i18n.defaultLocale = "en_US.UTF-8";

      systemd = {
        network.links."10-wlan0" = {
          matchConfig.MACAddress = "14:AC:60:29:82:AB";
          linkConfig.Name = "wlan0";
        };
        sleep.settings.Sleep = {
          HibernateDelaySec = "20m";
        };
      };

      security.sudo.wheelNeedsPassword = false;
      security.rtkit.enable = true;
      security.pam.services.swaylock = { };

      powerManagement.powertop.enable = true;
      programs = {
        nix-ld.enable = true;
        zsh.enable = true;
        dconf.enable = true;
        gnupg.agent = {
          enable = true;
          enableSSHSupport = true;
        };
      };

      environment.variables = {
        __ETC_ZSHRC_SOURCED = "1";
        __ETC_ZSHENV_SOURCED = "1";
        GDK_BACKEND = "wayland";
      };

      nixpkgs.config.allowUnfree = true;
      nixpkgs.overlays = [ inputs.yazi.overlays.default ];
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      nix.settings.max-jobs = lib.mkDefault 2;
      nix.settings.cores = lib.mkDefault 2;
      nix.settings.substituters = [
        "https://yazi.cachix.org"
        "https://niri.cachix.org"
        "https://noctalia.cachix.org"
      ];
      nix.settings.trusted-public-keys = [
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];

    };
}
