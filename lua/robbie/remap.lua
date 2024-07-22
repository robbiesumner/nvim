local keymap = vim.keymap

-- explore
keymap.set("n", "<leader>e", vim.cmd.Ex)

-- telescope: fuzzy finder
local builtin = require("telescope.builtin")

keymap.set("n", "<leader>pf", builtin.find_files, {})
keymap.set("n", "<C-p>", builtin.git_files, {})
keymap.set("n", "<leader>ps", builtin.live_grep, {})

-- setup keybindings on client attach
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local opts = { buffer = ev.buf }

        -- mappings
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
    end,
})

-- git blame
keymap.set("n", "<leader>gb", vim.cmd.GitBlameToggle)
