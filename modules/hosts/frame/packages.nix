{ ... }:
{
  dendritic.modules.nixos.frame =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        coreutils
        util-linux
        stdenv
        dbus-broker
        pciutils
        pstree
        wireguard-tools
        gnome.gvfs
        ntfs3g
        upower
        lm_sensors
        acpilight
        usbutils
      ];

      fonts.packages = with pkgs; [
        nerd-fonts.terminess-ttf
        noto-fonts
        noto-fonts-color-emoji
        terminus_font_ttf
        terminus_font
        liberation_ttf
        fira-code
        fira-code-symbols
        ubuntu-classic
        corefonts
      ];
      fonts.fontconfig.useEmbeddedBitmaps = true;
    };
}
