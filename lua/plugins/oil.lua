return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-mini/mini.icons" },
    opts = {},
    config = function()
      require("oil").setup()
    end,
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open Parent Directory" }
    }
  },
}
