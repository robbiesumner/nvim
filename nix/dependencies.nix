{pkgs}:
with pkgs; [
  ripgrep
  tree-sitter

  # lsp
  lua-language-server
  nixd
  pyright
  texlab
  tinymist
  yaml-language-server
  docker-language-server
  docker-compose-language-service
  vscode-css-languageserver
  qt6.qtdeclarative
  svelte-language-server
  typescript-language-server
  tailwindcss-language-server
  vscode-langservers-extracted

  # formatter
  stylua
  alejandra
  ruff
  bibtex-tidy
  typstyle
  prettier

  # tools
  (texliveMedium.withPackages (p: with p; [exam needspace]))
  biber
  zathura
  typst
  lilypond
  mpv
  ghostscript
]
