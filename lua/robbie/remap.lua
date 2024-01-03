vim.g.mapleader = " "

-- explore
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

--format
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
