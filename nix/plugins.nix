{pkgs}:
with pkgs.vimPlugins; [
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
  vimtex
  typst-preview-nvim
  nvim-lilypond-suite
]
