return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- lua helper
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
			-- completion capabilities
			"saghen/blink.cmp",
		},

		config = function()
			require("mason").setup()

			local capabilities = require("blink.cmp").get_lsp_capabilities()
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({ capabilities = capabilities })

					-- dedicated custom handlers go here
					-- ["lua_ls"] = function()
					-- require("lspconfig").lua_ls.setup {},
					-- ...
					-- end
				end,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then
						return
					end

					-- solved with conform
					-- formatting on write
					--          if client.supports_method('textDocument/formatting') then
					--            vim.api.nvim_create_autocmd('BufWritePre', {
					--              buffer = args.buf,
					--              callback = function()
					--                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
					--              end,
					--            })
					--          end

					-- keymaps
					vim.keymap.set("n", "gd", vim.lsp.buf.definition)
					vim.keymap.set("n", "gr", vim.lsp.buf.references)
					vim.keymap.set("n", "rn", vim.lsp.buf.rename)
				end,
			})
		end,
	},
}
