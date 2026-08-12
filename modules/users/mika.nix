{ config, ... }:
let
  inherit (config.dendritic.data.dotfiles) configDots configNvim;
in
{
  dendritic.modules.home.mika = { config, lib, pkgs, ... }:
    let
      link = config.lib.file.mkOutOfStoreSymlink;
      configDirs = builtins.attrNames (builtins.readDir "${configDots}/.config");
    in
    {
      home = {
        username = "mika";
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
      xdg.configFile = lib.genAttrs (
        builtins.filter (dir: !(builtins.elem dir [ "systemd" "nix" "yazi" ])) configDirs
      ) (dir: {
        source = link "${configDots}/.config/${dir}";
        recursive = true;
        force = true;
      });
    };

  dendritic.modules.nixos.mika = { pkgs, ... }: {
    users.users.mika = {
      isNormalUser = true;
      description = "mika";
      extraGroups = [ "networkmanager" "wheel" "docker" "kvm" "libvirtd" ];
      shell = pkgs.zsh;
    };
  };

  dendritic.modules.darwin.mika = { pkgs, ... }: {
    users.users.mika = { shell = pkgs.zsh; home = "/Users/mika"; };
    system.primaryUser = "mika";
  };
}
