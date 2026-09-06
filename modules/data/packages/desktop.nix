{ ... }:
{
  dendritic.modules.home.packages-wayland =
    {
      inputs,
      pkgs,
      lib,
      ...
    }:
    lib.mkIf (!pkgs.stdenv.hostPlatform.isDarwin) {
      home.packages = with pkgs; [
        swaybg
        swaylock
        xwayland-satellite
        fuzzel
        (inputs.dmenu-wl.packages.${stdenv.hostPlatform.system}.default.overrideAttrs (old: {
          postPatch = (old.postPatch or "") + ''
            cat > config.def.h <<'EOF'
            #include <stdint.h>

            static uint32_t color_bg = 0x000000f2;
            static uint32_t color_fg = 0xffffffff;
            static uint32_t color_input_bg = 0x000000f2;
            static uint32_t color_input_fg = 0xffffffff;
            static uint32_t color_prompt_bg = 0x000000f2;
            static uint32_t color_prompt_fg = 0xffffffff;
            static uint32_t color_selected_bg = 0xffc87fff;
            static uint32_t color_selected_fg = 0x000000ff;
            static uint32_t color_border = 0xffc87fff;

            static int32_t panel_height = 20;
            static int32_t min_width = 600;
            static int32_t border_width = 3;

            static enum dmenu_position position = DMENU_POSITION_CENTER;

            static char *font = "Terminus 14";

            static int lines = 15;

            static int timeout = 3;
            EOF
          '';
        }))
        cliphist
        wl-clipboard
        grim
        mako
        swayidle
        ghostty
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
    };

  dendritic.modules.home.packages-darwin =
    { pkgs, lib, ... }:
    lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
      home.packages = with pkgs; [
        stats
      ];
    };

  dendritic.modules.home.packages-network = { pkgs, lib, ... }: {
    home.packages =
      with pkgs;
      [
        whois
        nmap
        dconf
        wireguard-tools
        localsend
      ]
      ++ lib.optionals (!pkgs.stdenv.hostPlatform.isDarwin) [
        uxplay
        nextcloud-client
        tigervnc
      ];
  };

  dendritic.modules.home.packages-fonts = { pkgs, ... }: {
    home.packages = with pkgs; [
      noto-fonts-color-emoji
      font-awesome
      noto-fonts
    ];
  };

  dendritic.modules.home.packages-media = { pkgs, lib, ... }: {
    home.packages =
      with pkgs;
      [
        mpv
        spotify
        inkscape
        imagemagick
        ghostscript
        pandoc
        mediainfo
        transmission_4
      ]
      ++ lib.optionals (!pkgs.stdenv.hostPlatform.isDarwin) [
        vlc
        sxiv
        gimp
        chromium
        power-profiles-daemon
        libnotify
        pavucontrol
        xkblayout-state
        cryptsetup
        rsync
        devour
        pamixer
        pulseaudio
        xdg-utils
      ];
  };

  dendritic.modules.home.packages-communication = { pkgs, ... }: {
    home.packages = with pkgs; [
      discord
      telegram-desktop
    ];
  };

  dendritic.modules.home.packages-files = { pkgs, lib, ... }: {
    home.packages =
      with pkgs;
      [
        lf
        yazi
        file
        ffmpegthumbnailer
        ffmpeg
        poppler-utils
        atool
        odt2txt
        djvulibre
        ueberzugpp
        _7zz-rar
        obsidian
      ]
      ++ lib.optionals (!pkgs.stdenv.hostPlatform.isDarwin) [
        nautilus
        gnome-epub-thumbnailer
        zathura
        zathuraPkgs.zathura_ps
        zathuraPkgs.zathura_cb
        zathuraPkgs.zathura_djvu
        zathuraPkgs.zathura_pdf_mupdf
      ];
  };

  dendritic.modules.home.packages-office = { pkgs, lib, ... }: {
    home.packages =
      with pkgs;
      [ groff ]
      ++ lib.optionals (!pkgs.stdenv.hostPlatform.isDarwin) [
        texliveFull
        libreoffice-stable
      ];
  };

  dendritic.modules.home.packages-email = { pkgs, ... }: {
    home.packages = with pkgs; [
      neomutt
      notmuch
      msmtp
      isync
      abook
      lynx
    ];
  };
}
