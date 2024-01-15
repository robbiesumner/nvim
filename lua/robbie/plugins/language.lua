return {
    -- treesitter: parsing
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup {

                -- A list of parser names, or "all" (the five listed parsers should always be installed)
                ensure_installed = { "javascript", "typescript", "c", "lua", "rust" },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
                auto_install = false,

                highlight = {
                    enable = true,

                    additional_vim_regex_highlighting = false,
                },
            }
        end,
    },

    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            --- Uncomment these if you want to manage the language servers from neovim
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- LSP Support
            { "neovim/nvim-lspconfig" },
            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "L3MON4D3/LuaSnip" },
        },
        config = function()
            local lsp = require("lsp-zero")
            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end)

            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = { "tsserver", "rust_analyzer", "gopls", "lua_ls" },
                handlers = {
                    lsp.default_setup,
                    lua_ls = function()
                        require('lspconfig').lua_ls.setup({
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim" },
                                    },
                                },
                            },
                        })
                    end,
                },
            })

            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                formatting = lsp.cmp_format(),
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                }),
            })
        end,
    },
}
