{ config, ... }:
let
  modules = config.dendritic.modules.home;
in
{
  dendritic.modules.home.mika-profile = {
    home = {
      homeDirectory = "/home/mika";
      stateVersion = "26.05";
    };
    imports = [
      modules.mika
      modules.packages-system
      modules.packages-shell
      modules.packages-cli
      modules.packages-wayland
      modules.packages-darwin
      modules.packages-network
      modules.packages-fonts
      modules.packages-media
      modules.packages-communication
      modules.packages-files
      modules.packages-office
      modules.packages-email
      modules.packages-development
      modules.nix-settings
      modules.firefox
      modules.ghostty
      modules.yazi
      modules.theme
      modules.xdg
      modules.systemd-services
      modules.niri
      modules.noctalia
    ];
  };

  dendritic.configurations.home.mika = {
    system = "x86_64-linux";
    module = modules.mika-profile;
  };
}
