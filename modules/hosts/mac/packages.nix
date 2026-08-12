{ ... }:
{
  dendritic.modules.darwin.mac =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        coreutils
        stdenv
        pciutils
        util-linux
        pstree
        wireguard-tools
      ];

      fonts.packages = with pkgs; [
        nerd-fonts.terminess-ttf
        terminus_font_ttf
        terminus_font
      ];
    };
}
