{ ... }:
{
  dendritic.modules.home.dmenu-mac =
    { inputs, pkgs, lib, ... }:
    lib.mkIf pkgs.stdenv.hostPlatform.isDarwin (let
      dmenu-mac = inputs.dmenu-mac.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
        postPatch = (old.postPatch or "") + ''
          cat > config.def.h <<'EOF'
          #include <stdint.h>

          static const char *color_bg = "#000000f2";
          static const char *color_fg = "#ffffffff";
          static const char *color_selected_bg = "#ffc87fff";
          static const char *color_selected_fg = "#000000ff";
          static const char *color_border = "#ffc87fff";

          static CGFloat panel_height = 20;
          static CGFloat min_width = 600;
          static CGFloat border_width = 3;
          static enum dmenu_position position = DMENU_POSITION_CENTER;
          static const char *font = "Terminus (TTF) 15";
          static NSInteger lines = 15;
          static NSTimeInterval timeout = 3;
          EOF
        '';
      });
      history = ''$HOME/.local/state/dmenu-mac/clipboard-history'';
    in {
      home.packages = [
        dmenu-mac
        (pkgs.writeShellApplication {
          name = "dmenu-mac-clipboard-watch";
          runtimeInputs = with pkgs; [
            coreutils
            gnugrep
            gawk
          ];
          text = ''
            history=${history}
            tmp="$history.tmp"
            mkdir -p "$(dirname "$history")"
            last=""

            trap 'rm -f "$tmp"' EXIT

            while :; do
              value="$(/usr/bin/pbpaste 2>/dev/null || true)"
              if [ -n "$value" ] && [ "$value" != "$last" ]; then
                if ! grep -Fqx "$value" "$history" 2>/dev/null; then
                  {
                    printf '%s\n' "$value"
                    if [ -f "$history" ]; then
                      cat "$history"
                    fi
                  } | awk 'NF && !seen[$0]++' | head -n 500 > "$tmp"
                  mv "$tmp" "$history"
                fi
                last="$value"
              fi
              sleep 0.5
            done
          '';
        })
        (pkgs.writeShellApplication {
          name = "dmenu-mac-clipboard";
          runtimeInputs = [ dmenu-mac ];
          text = ''
            history=${history}
            [ -s "$history" ] || exit 0
            selection="$(dmenu-mac -i -p clipboard < "$history")" || exit 0
            [ -n "$selection" ] || exit 0
            printf '%s' "$selection" | /usr/bin/pbcopy
          '';
        })
        (pkgs.writeShellApplication {
          name = "dmenu-mac-clipboard-clear";
          runtimeInputs = [ dmenu-mac ];
          text = ''
            history=${history}
            [ -f "$history" ] || exit 0
            choice="$(printf 'yes\nno\n' | dmenu-mac -p 'clear clipboard
              history?')" || exit 0
            [ "$choice" = yes ] || exit 0
            : > "$history"
          '';
        })
      ];
    });
}
