return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-neotest/neotest-python",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"mfussenegger/nvim-dap",
	},
	config = function()
		local neotest = require("neotest")
		neotest.setup({
			adapters = {
				require("neotest-python")({}),
			},
		})

		vim.keymap.set("n", "t", neotest.run.run)
		vim.keymap.set("n", "T", function()
			neotest.run.run(vim.fn.expand("%"))
		end)
		vim.keymap.set("n", "<leader>dt", function()
			neotest.run.run({ strategy = "dap" })
		end)
	end,
}
