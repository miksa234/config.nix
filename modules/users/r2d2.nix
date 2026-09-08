{ config, ... }:
let
  inherit (config.dendritic) modules;
in
{
  dendritic.modules.home.r2d2 =
    {
      pkgs,
      lib,
      config,
      inputs,
      ...
    }:
    let
      link = config.lib.file.mkOutOfStoreSymlink;
      dots = inputs.dotfiles;
      nvim = inputs.neovim-config;
      dirs = builtins.filter (dir: dir != "systemd") (
        builtins.attrNames (builtins.readDir "${dots}/config")
      );
    in
    {
      home = {
        username = "r2d2";
        homeDirectory = "/home/r2d2";
        stateVersion = "25.11";
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

  dendritic.modules.nixos.r2d2 = { pkgs, ... }: {
    users.users.r2d2 = {
      isNormalUser = true;
      description = "r2d2";
      extraGroups = [ "wheel" ];
      shell = pkgs.zsh;
    };
    home-manager.users.r2d2.imports = [ modules.home.r2d2-profile ];
  };
}
