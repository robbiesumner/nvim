-- detect all html files as html, i had problem with htmlangular
-- so that language server can operate correctly
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.html",
  callback = function()
    vim.cmd.set("filetype=html")
  end
})
