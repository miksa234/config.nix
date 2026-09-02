{ ... }:
{
  dendritic.data.dotfiles = {
    configDots = builtins.fetchGit {
      url = "https://github.com/miksa234/config.git";
      ref = "main";
      rev = "971814443ad82defdf7f3f37da5b8a4f8a586087";
    };

    configNvim = builtins.fetchGit {
      url = "https://github.com/miksa234/config.nvim.git";
      ref = "main";
      rev = "9e8b73daa6a7f49ce59d0356e77712fa10eec912";
    };
  };
}
