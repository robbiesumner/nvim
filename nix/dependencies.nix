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

  # formatter
  stylua
  alejandra
  ruff
  bibtex-tidy
  typstyle

  # tools
  (texliveMedium.withPackages (p: with p; [exam needspace]))
  biber
  zathura
  typst
]
