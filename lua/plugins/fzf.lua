local fzf = require("fzf-lua")

fzf.setup()

vim.keymap.set("n", "<leader> ", fzf.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>ss", fzf.builtin, { desc = "[S]earch for [H]elp" })
vim.keymap.set("n", "<leader>sh", fzf.helptags, { desc = "[S]earch for [H]elp" })
vim.keymap.set("n", "<leader>sk", fzf.keymaps, { desc = "[S]earch for [K]eymaps" })
vim.keymap.set("n", "<leader>sg", fzf.live_grep_native, { desc = "[S]earch with [G]rep" })
vim.keymap.set("v", "<leader>sw", fzf.grep_visual, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sd", fzf.diagnostics_workspace, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", fzf.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>so", fzf.oldfiles, { desc = "[S]earch [O]ld / recently opened files" })
vim.keymap.set("n", "<leader>sc", fzf.commands, { desc = "[S]earch [C]ommands" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("fzf-lsp-attach", { clear = true }),
  callback = function(event)
    local buf = event.buf

    vim.keymap.set("n", "gr", fzf.lsp_references, { buffer = buf, desc = "[G]oto [R]eferences" })

    vim.keymap.set("n", "<leader>ds", fzf.lsp_document_symbols, { buffer = buf, desc = "Open [D]ocument [S]ymbols" })
    vim.keymap.set(
      "n",
      "<leader>ws",
      fzf.lsp_live_workspace_symbols,
      { buffer = buf, desc = "Open [W]orkspace [S]ymbols" }
    )

    vim.keymap.set("n", "<leader>ca", fzf.lsp_code_actions, { buffer = buf, desc = "[C]ode [A]ctions" })
  end,
})
