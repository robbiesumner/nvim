-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    -- bootstrap lazy.nvim
    -- stylua: ignore
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
        lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- set up plug-ins
require("lazy").setup({
    -- colorscheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            vim.cmd("colorscheme catppuccin")
        end
    },

    -- fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        version = "0.1.5",
        -- or                            , branch = "0.1.x",
        dependencies = { { "nvim-lua/plenary.nvim" } }
    },

    -- simplify lsp setup
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
        }
    },

    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
})
