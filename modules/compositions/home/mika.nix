{ config, ... }:
let
  modules = config.dendritic.modules.home;
in
{
  dendritic.modules.home.mika = { lib, hostPlatform, ... }: {
    home = {
      homeDirectory = "/home/mika";
      stateVersion = "26.05";
    };
    imports = [
      modules.packages-system
      modules.packages-shell
      modules.packages-cli
      modules.packages-network
      modules.packages-fonts
      modules.packages-media
      modules.packages-communication
      modules.packages-files
      modules.packages-office
      modules.packages-email
      modules.packages-development
      modules.private-dotfiles
      modules.nix-settings
      modules.opencode
      modules.firefox
      modules.ghostty
      modules.yazi
    ]
    ++ lib.optionals hostPlatform.isLinux [
      modules.packages-wayland
      modules.systemd-services
      modules.xdg
      modules.niri
      modules.noctalia
      modules.theme
    ]
    ++ lib.optionals hostPlatform.isDarwin [
      modules.packages-darwin
      modules.launchd-services
      modules.dmenu-mac
    ];
  };

  dendritic.configurations.home.mika = {
    system = "x86_64-linux";
    module = modules.mika;
  };
}
