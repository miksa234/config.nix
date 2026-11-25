{ ... }:
{
  dendritic.modules.home.ghostty =
    {
      pkgs,
      lib,
      ...
    }:
    let
      isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
    in
    {
      home.packages = if (isDarwin) then [ pkgs.ghostty-bin ] else [ pkgs.ghostty ];

      xdg.configFile."ghostty/config.ghostty" = {
        text = ''
          font-family = Terminus (TTF)
          font-size = 15
          font-style-italic = false
          font-style-bold-italic = false


          background = #000000
          foreground = #EEEEEE
          palette = 0=#000000
          palette = 1=#ed0b0b
          palette = 2=#40a62f
          palette = 3=#f2e635
          palette = 4=#327bd1
          palette = 5=#b30ad0
          palette = 6=#3975b8
          palette = 7=#EEEEEE
          palette = 8=#262626
          palette = 9=#b55454
          palette = 10=#78a670
          palette = 11=#faf380
          palette = 12=#68a7d4
          palette = 13=#c583d0
          palette = 14=#3975b8
          palette = 15=#EEEEEE

          cursor-style = block
          cursor-style-blink = false

          background-opacity = 0.98

          term = xterm-256color

          selection-word-chars = " "
          confirm-close-surface = false
          window-inherit-working-directory = false
          tab-inherit-working-directory = false
          split-inherit-working-directory = false
          mouse-hide-while-typing = false

          keybind = alt+c=copy_to_clipboard
          keybind = alt+v=paste_from_clipboard
          keybind = alt+u=scroll_page_lines:-1
          keybind = alt+d=scroll_page_lines:1
          keybind = alt+shift+u=scroll_page_up
          keybind = alt+shift+d=scroll_page_down
          keybind = alt+page_up=scroll_page_up
          keybind = alt+page_down=scroll_page_down
          keybind = alt+shift+o=copy_url_to_clipboard
          keybind = alt+shift+l=copy_url_to_clipboard

          keybind = alt+shift+equal=increase_font_size:1
          keybind = alt+minus=decrease_font_size:1
          keybind = alt+equal=reset_font_size
        '';
        force = true;
      };
    };
}
