{
  pkgs,
  lib,
  self,
  supportJupyter ? false,
}: let
  binPath = lib.makeBinPath (with pkgs;
    [
      ripgrep
      tree-sitter
      lua-language-server
      nixd
      pyright
      yaml-language-server
      docker-language-server
      vscode-css-languageserver
      stylua
      alejandra
      ruff
      imagemagick
    ]
    ++ lib.optionals supportJupyter [
      python3Packages.jupytext
      quarto
    ]);

  pythonEnv = pkgs.python3.withPackages (ps:
    with ps;
      [
        pynvim
      ]
      ++ lib.optionals supportJupyter [
        jupyter-client
        nbformat
        pillow
        pnglatex
        requests
      ]);

  vimPlugins = with pkgs.vimPlugins;
    [
      catppuccin-nvim
      nvim-lspconfig
      lazydev-nvim
      nvim-treesitter.withAllGrammars
      lualine-nvim
      fzf-lua
      yuck-vim
      gitsigns-nvim
      blink-cmp
      conform-nvim
      mini-icons
      which-key-nvim
      image-nvim
    ]
    ++ lib.optionals supportJupyter [
      molten-nvim
      jupytext-nvim
      quarto-nvim
      otter-nvim
    ];

  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    withRuby = false;
    plugins = vimPlugins;
    customLuaRC = ''
      vim.g.python3_host_prog = "${pythonEnv}/bin/python3"
      vim.opt.runtimepath:prepend("${self}/")
      vim.opt.runtimepath:append("${self}/after")
      dofile("${self}/init.lua")

      vim.g.jupyter = ${
        if supportJupyter
        then "true"
        else "false"
      }
    '';
  };
in
  pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (neovimConfig
    // {
      wrapperArgs =
        neovimConfig.wrapperArgs
        ++ [
          "--suffix"
          "PATH"
          ":"
          "${binPath}"
        ];
    })
