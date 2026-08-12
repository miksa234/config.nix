{ ... }:
{
  dendritic.data.dotfiles = {
    configDots = builtins.fetchGit {
      url = "https://github.com/miksa234/config.git";
      ref = "main";
      rev = "47fa6bcbf564c545d9c5d594a776aa7d2748f900";
    };

    configNvim = builtins.fetchGit {
      url = "https://github.com/miksa234/config.nvim.git";
      ref = "main";
      rev = "f789ddd34584815f2a91cae5a7b3173b4df30d75";
    };
  };
}
