{ ... }:
{
  dendritic.modules.home.packages-xorg-suckless =
    { pkgs, ... }:
    let
      fetchSucklessRepo =
        repo: hash:
        pkgs.fetchgit {
          url = "git://popovic.xyz/${repo}.git";
          inherit hash;
        };
      suckless = with pkgs; {
        dwm = dwm.overrideAttrs (old: {
          src = fetchSucklessRepo "dwm" "sha256-Hj985b6fRcYZm49Sd6188OewhCrBk5N0uWwQF3q7TH0=";
          buildInputs = old.buildInputs ++ [ libxcb ];
        });
        st = st.overrideAttrs (old: {
          src = fetchSucklessRepo "st" "sha256-RYWB2LmEAafQUXhhtKi+7iJ6Ey5qLyTjjfLwOvNhu6U=";
        });
        dmenu = dmenu.overrideAttrs (old: {
          src = fetchSucklessRepo "dmenu" "sha256-YPtt7+wMickAYs271+lgKaUlWjxPwnsOJmaN/BS3ZzU=";
        });
        slock = slock.overrideAttrs (old: {
          src = fetchSucklessRepo "slock" "sha256-4cKVyYRqgv9YGYYHFzzkIoJhdMlzb5GC72RQsCSEbG0=";
          buildInputs =
            old.buildInputs
            ++ (with xorg; [
              libxinerama
              imlib2
              libxft
            ]);
        });
        inherit dwmblocks;
      };
    in
    {
      home.packages =
        with pkgs;
        [
          xclip
          feh
          redshift
          xidlehook
          xcompmgr
          xdotool
          scrot
          dunst
        ]
        ++ (with suckless; [
          dwm
          st
          dmenu
          slock
          dwmblocks
        ]);
    };
}
