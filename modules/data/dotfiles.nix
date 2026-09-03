{ ... }:
{
  dendritic.data.dotfiles = {
    configDots = builtins.fetchGit {
      url = "https://github.com/miksa234/config.git";
      ref = "main";
      rev = "5bed4f9acddc734ac50565a0a6b2ea7eb60bb6e3";
    };

    configNvim = builtins.fetchGit {
      url = "https://github.com/miksa234/config.nvim.git";
      ref = "main";
      rev = "9e8b73daa6a7f49ce59d0356e77712fa10eec912";
    };
  };
}
