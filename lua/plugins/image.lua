require("image").setup({
  backend = "kitty",
  kitty_method = "normal",
  integrations = {
    markdown = {
      enabled = true,
      download_remote_images = true,
    },
  },
})
