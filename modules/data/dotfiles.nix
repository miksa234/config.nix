{ ... }:
{
  dendritic.data.dotfiles = {
    configDots = builtins.fetchGit {
      url = "https://github.com/miksa234/config.git";
      ref = "main";
      rev = "237b5f39b6aceeed91b6942c1a9d9f7ce5d70a4e";
    };

    configNvim = builtins.fetchGit {
      url = "https://github.com/miksa234/config.nvim.git";
      ref = "main";
      rev = "9e8b73daa6a7f49ce59d0356e77712fa10eec912";
    };
  };
}
