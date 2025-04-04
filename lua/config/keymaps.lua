if not vim.g.vscode then
	local terminal = require("custom.terminal")

	vim.keymap.set("n", "<leader>t", terminal.toggle_floating_terminal)
	vim.keymap.set("n", "<leader>st", terminal.create_small_terminal)
	vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")
end
