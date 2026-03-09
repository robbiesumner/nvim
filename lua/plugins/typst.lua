vim.api.nvim_create_autocmd("FileType", {
  pattern = "typst",
  callback = function()
    require("typst-preview").setup()
    vim.keymap.set("n", "<leader>t", "<cmd>TypstPreviewToggle<CR>", { desc = "Toggle [T]ypst preview" })
  end,
})
