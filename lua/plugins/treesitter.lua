local filetypes = { "lua", "nix", "yaml", "python", "markdown", "markdown_inline" }

require("nvim-treesitter").install(filetypes)
vim.api.nvim_create_autocmd("FileType", {
  pattern = filetypes,
  callback = function()
    vim.treesitter.start()
  end,
})
