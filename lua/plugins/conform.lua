local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff" },
    nix = { "alejandra" },
    quarto = { "injected" },
  },
  format_on_save = {
    lsp_format = "fallback",
  },
  default_format_opts = {
    lsp_format = "fallback",
    quiet = true,
  },
})

vim.keymap.set("n", "<leader>f", conform.format, { desc = "[F]ormat buffer" })
