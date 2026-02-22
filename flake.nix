{
  description = "My neovim configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages = forAllSystems (
      system: let
        pkgs = import nixpkgs {inherit system;};

        binPath = pkgs.lib.makeBinPath (with pkgs; [
          ripgrep
          tree-sitter
          # language servers
          lua-language-server
          nixd
          pyright
          yaml-language-server
          vscode-css-languageserver
          # formatters
          stylua
          alejandra
          ruff
          # molten
          imagemagick
          python3Packages.jupytext
          quarto
        ]);

        pythonEnv = pkgs.python3.withPackages (ps:
          with ps; [
            pynvim
            jupyter-client
            nbformat
            pillow
            pnglatex
            requests
          ]);

        vimPlugins = with pkgs.vimPlugins; [
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
          # data science
          molten-nvim
          image-nvim
          jupytext-nvim
          quarto-nvim
          otter-nvim
        ];

        neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
          withRuby = false;
          plugins = vimPlugins;
          customLuaRC = ''
            -- setup python
            vim.g.python3_host_prog = "${pythonEnv}/bin/python3"


            vim.opt.runtimepath:prepend("${self}/")
            vim.opt.runtimepath:append("${self}/after")
            dofile("${self}/init.lua")
          '';
        };

        wrappedNeovim = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (neovimConfig
          // {
            wrapperArgs =
              neovimConfig.wrapperArgs
              ++ [
                "--prefix"
                "PATH"
                ":"
                "${binPath}"
              ];
          });
      in {
        default = wrappedNeovim;
      }
    );

    apps = forAllSystems (system: {
      default = {
        type = "app";
        program = "${self.packages.${system}.default}/bin/nvim";
      };
    });
  };
}
