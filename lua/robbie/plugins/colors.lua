return {
    {
        "folke/tokyonight.nvim",
        config = function()
            vim.cmd("colorscheme tokyonight-night")

            -- set transparent background
            vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
        end
    }
}
