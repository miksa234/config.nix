{ ... }:
{
  dendritic.modules.home.mika =
    {
      config,
      lib,
      pkgs,
      inputs,
      ...
    }:
    let
      link = config.lib.file.mkOutOfStoreSymlink;
      dots = inputs.dotfiles;
      nvim = inputs.neovim-config;
      dirs = builtins.filter (dir: !(builtins.elem dir [ "systemd" "nix" "yazi" ])) (
        builtins.attrNames (builtins.readDir "${dots}/config")
      );
    in
    {
      home = {
        username = "mika";
        file = {
          ".zshenv" = {
            source = link "${dots}/zshenv";
            force = true;
          };
          ".local" = {
            source = link "${dots}/local";
            recursive = true;
            force = true;
          };
          ".config/nvim" = {
            source = link "${nvim}";
            recursive = true;
            force = true;
          };
          ".config/nix-zsh-plugins.zsh".text = ''
            source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
            source ${pkgs.zsh-system-clipboard}/share/zsh/zsh-system-clipboard/zsh-system-clipboard.zsh
          '';
        };
      };
      xdg.configFile = lib.genAttrs dirs (dir: {
        source = link "${dots}/config/${dir}";
        recursive = true;
        force = true;
      });
    };

  dendritic.modules.nixos.mika = { pkgs, ... }: {
    users.users.mika = {
      isNormalUser = true;
      description = "mika";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "kvm"
        "libvirtd"
      ];
      shell = pkgs.zsh;
    };
  };

  dendritic.modules.darwin.mika = { pkgs, ... }: {
    users.users.mika = {
      shell = pkgs.zsh;
      home = "/Users/mika";
    };
    system.primaryUser = "mika";
  };
}
