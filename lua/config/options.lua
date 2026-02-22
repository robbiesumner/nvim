vim.g.mapleader = " "

vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 10

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

vim.o.smartindent = true
vim.o.autoindent = true

vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.inccommand = "split"

vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = true,
  jump = { float = true },
})
