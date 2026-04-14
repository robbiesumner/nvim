require("nvls").setup({
  player = {
    options = {
      executable = "fluidsynth",
      fluidsynth_flags = {
        vim.g.soundfont_path,
      },
    },
  },
})
