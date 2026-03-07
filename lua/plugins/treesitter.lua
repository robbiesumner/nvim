local filetypes = { "lua", "nix", "yaml", "dockerfile", "python", "markdown", "markdown_inline", "qml" }

require("nvim-treesitter").install(filetypes)
vim.api.nvim_create_autocmd("FileType", {
  pattern = filetypes,
  callback = function()
    vim.treesitter.start()
  end,
})
