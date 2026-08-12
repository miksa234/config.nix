{ config, ... }:
let
  inherit (config.dendritic) data modules;
in
{
  dendritic.modules.home.r2d2 = { pkgs, lib, config, ... }:
    let
      link = config.lib.file.mkOutOfStoreSymlink;
      inherit (data.dotfiles) configDots configNvim;
      configDirs = builtins.attrNames (builtins.readDir "${configDots}/.config");
    in {
      home = {
        username = "r2d2";
        homeDirectory = "/home/r2d2";
        stateVersion = "25.11";
        file = {
          ".zshenv" = { source = link "${configDots}/.zshenv"; force = true; };
          ".local" = { source = link "${configDots}/.local"; recursive = true; force = true; };
          ".config/nvim" = { source = link "${configNvim}"; recursive = true; force = true; };
          ".config/nix-zsh-plugins.zsh".text = ''
            source ${pkgs.zsh-fast-syntax-highlighting}/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
            source ${pkgs.zsh-system-clipboard}/share/zsh/zsh-system-clipboard/zsh-system-clipboard.zsh
          '';
        };
      };
      xdg.configFile = lib.genAttrs (builtins.filter (dir: dir != "systemd") configDirs) (dir: {
        source = link "${configDots}/.config/${dir}";
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
