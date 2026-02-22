require("catppuccin").setup({
  flavour = "mocha",
  transparent_background = true,
  float = {
    transparent = true,
    solid = true,
  },
  integrations = {
    which_key = true,
  },
})
vim.cmd.colorscheme("catppuccin")
