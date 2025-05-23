return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		-- file search
		vim.keymap.set("n", "<leader>fd", require("telescope.builtin").find_files)
		-- grep
		vim.keymap.set("n", "<leader>fs", require("telescope.builtin").live_grep)
		-- help
		vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags)

		-- edit neovim config
		vim.keymap.set("n", "<leader>en", function()
			require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
		end)
	end,
}
