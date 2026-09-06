{ ... }:
{
  dendritic.modules.home.packages-wayland =
    { pkgs, lib, ... }:
    lib.mkIf (!pkgs.stdenv.hostPlatform.isDarwin) {
      home.packages = with pkgs; [
        swaybg
        swaylock
        xwayland-satellite
        fuzzel
        (dmenu-wayland.overrideAttrs (_: {
          src = pkgs.fetchgit {
            url = "https://github.com/miksa234/dmenu-wl";
            hash = "sha256-9EzNdB1GAlO0SV+AVVwS4uNXWMhimgivOdzjhwmmEkg=";
          };
          patches = [ ];
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
