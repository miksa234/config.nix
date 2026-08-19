{ ... }:
{
  dendritic.modules.home.yazi =
    {
      pkgs,
      lib,
      ...
    }:
    {
      programs.yazi = {
        enable = true;
        enableZshIntegration = true;

        settings = { };

        initLua = ''
          require("full-border"):setup {
            type = ui.Border.PLAIN,
          }

          Status:children_add(function(self)
            local h = self._current.hovered
            if h and h.link_to then
              return " -> " .. tostring(h.link_to)
            else
              return ""
            end
          end, 3300, Status.LEFT)

          Status:children_add(function()
            local h = cx.active.current.hovered
            if not h or ya.target_family() ~= "unix" then
              return ""
            end

            return ui.Line {
              ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
              ":",
              ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
              " ",
            }
          end, 500, Status.RIGHT)
        '';

        plugins = {
          smart-enter = pkgs.yaziPlugins.smart-enter;
          full-border = pkgs.yaziPlugins.full-border;
        };

        keymap = {
          mgr.prepend_keymap = [
            {
              on = [ "W" ];
              run = "shell '$TERMINAL' --block";
              desc = "Open terminal here";
            }
            {
              on = [ "<C-s>" ];
              run = "hidden toggle";
              desc = "Toggle hidden files";
            }
            {
              on = [ "l" ];
              run = "plugin 'smart-enter'";
              desc = "Enter directory or open file";
            }
            {
              on = [ "<Enter>" ];
              run = "plugin 'smart-enter'";
              desc = "Enter directory or open file";
            }
          ];
        };
      };

      xdg.configFile."yazi/yazi.toml" = {
        text = ''
          [mgr]
          show_hidden = false
          sort_dir_first = true
          sort_by = "natural"
          scrolloff = 5
          ratio = [1, 2, 5]

          [opener]
          zathura-open = [
            { run = "zathura %s", orphan = true, for = "unix" },
          ]
          nvim-edit = [
            { run = "nvim %s", block = true, for = "unix" },
          ]
          sxiv-open = [
            { run = "sxiv %s", orphan = true, for = "unix" },
          ]
          mpv-play = [
            { run = "mpv %s", orphan = true, for = "unix" },
          ]
          libreoffice-open = [
            { run = "libreoffice %s", orphan = true, for = "unix" },
          ]
          gimp-open = [
            { run = "gimp %s", orphan = true, for = "unix" },
          ]
          xdg-open = [
            { run = "xdg-open %s1", desc = "Open", for = "unix" },
          ]

          [open]
          prepend_rules = [
            { url = "*.xlsx", use = "libreoffice-open" },
            { url = "*.xls",  use = "libreoffice-open" },
            { url = "*.docx", use = "libreoffice-open" },
            { url = "*.pptx", use = "libreoffice-open" },
            { url = "*.odt",  use = "libreoffice-open" },
            { url = "*.ods",  use = "libreoffice-open" },

            { mime = "application/pdf",              use = "zathura-open" },
            { mime = "image/vnd.djvu",               use = "zathura-open" },
            { mime = "application/postscript",       use = "zathura-open" },
            { mime = "application/epub+zip",         use = "zathura-open" },

            { mime = "text/*",                       use = "nvim-edit" },
            { mime = "application/json",             use = "nvim-edit" },
            { mime = "application/javascript",       use = "nvim-edit" },
            { mime = "inode/x-empty",                use = "nvim-edit" },
            { mime = "application/x-subrip",         use = "nvim-edit" },
            { mime = "application/pgp-encrypted",    use = "nvim-edit" },

            { mime = "image/x-xcf",                  use = "gimp-open" },
            { mime = "image/svg+xml",                use = "sxiv-open" },
            { mime = "image/*",                      use = "sxiv-open" },

            { mime = "audio/*",                      use = "mpv-play" },
            { mime = "video/*",                      use = "mpv-play" },

            { mime = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", use = "libreoffice-open" },
            { mime = "application/vnd.openxmlformats-officedocument.wordprocessingml.document", use = "libreoffice-open" },
            { mime = "application/vnd.openxmlformats-officedocument.presentationml.presentation", use = "libreoffice-open" },
            { mime = "application/vnd.ms-powerpoint", use = "libreoffice-open" },
            { mime = "application/vnd.oasis.opendocument.text", use = "libreoffice-open" },
            { mime = "application/vnd.oasis.opendocument.spreadsheet", use = "libreoffice-open" },
            { mime = "application/vnd.oasis.opendocument.spreadsheet-template", use = "libreoffice-open" },
            { mime = "application/vnd.oasis.opendocument.presentation", use = "libreoffice-open" },
            { mime = "application/vnd.oasis.opendocument.presentation-template", use = "libreoffice-open" },
            { mime = "application/vnd.oasis.opendocument.graphics", use = "libreoffice-open" },
            { mime = "application/vnd.oasis.opendocument.graphics-template", use = "libreoffice-open" },
            { mime = "application/vnd.oasis.opendocument.formula", use = "libreoffice-open" },
            { mime = "application/vnd.oasis.opendocument.database", use = "libreoffice-open" },
          ]
        '';
      };
    };
}
