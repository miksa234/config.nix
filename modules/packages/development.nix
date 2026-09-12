{ ... }:
{
  dendritic.modules.home.packages-development = { pkgs, ... }: {
    home.packages = with pkgs; [
      gh
      zig
      tree-sitter
      python313Packages.tiktoken
      python313Packages.pylatexenc
      luajitPackages.jsregexp
      nil
      marksman
      bash-language-server
      clang-tools
      docker-compose-language-service
      docker-language-server
      dockerfile-language-server
      lua-language-server
      tailwindcss-language-server
      texlab
      typescript-language-server
      vscode-langservers-extracted
      vscode-solidity-server
      yaml-language-server
      zls
      luajitPackages.luacheck
      nixfmt
      prettier
      stylua
      nodejs
      pnpm
      cmake
      gnumake
      gcc
      luarocks
      javaPackages.compiler.openjdk17
      lua5_1
      go
      ruby
      php
      julia-bin
      (python3.withPackages (ps: with ps; [
        pip
        black
        debugpy
        python-lsp-server
      ] ++ python-lsp-server.optional-dependencies.all))
      rustup
      azure-cli
    ];
  };
}
