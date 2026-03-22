local filetypes = {
  "lua",
  "nix",
  "yaml",
  "dockerfile",
  "python",
  "markdown",
  "markdown_inline",
  "qml",
  "latex",
  "bibtex",
  "typst",
  "svelte",
  "typescript",
  "javascript",
  "css",
  "html",
  "sql",
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = filetypes,
  callback = function()
    vim.treesitter.start()
  end,
})
