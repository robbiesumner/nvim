require("config.lazy")

-- 4 wide space indenting
vim.opt.expandtab = true
vim.opt.shiftwidth = 4

-- relative numbers
vim.opt.relativenumber = true
vim.opt.number = true
-- scrolling
vim.opt.scrolloff = 8

-- use clipboard as buffer
vim.opt.clipboard = "unnamedplus"

-- source lua files
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")

-- terminal
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    -- turn off line numbers
    vim.opt.relativenumber = false
    vim.opt.number = false
  end,
})

vim.keymap.set("n", "<leader>st", function()
  vim.cmd.new()
  vim.cmd.wincmd("J")
  vim.cmd.term()
  vim.api.nvim_win_set_height(0, 15)
end)

-- open explorer
vim.keymap.set("n", "-", "<cmd>Oil<CR>")
