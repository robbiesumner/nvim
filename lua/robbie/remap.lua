local keymap = vim.keymap

-- explore
keymap.set("n", "<leader>e", vim.cmd.Ex)

-- telescope: fuzzy finder
local builtin = require("telescope.builtin")

keymap.set("n", "<leader>pf", builtin.find_files, {})
keymap.set("n", "<C-p>", builtin.git_files, {})
keymap.set("n", "<leader>ps", builtin.live_grep, {})

-- harpoon: fast file navigation
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

keymap.set("n", "<leader>a", mark.add_file)
keymap.set("n", "<C-e>", ui.toggle_quick_menu)

keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
keymap.set("n", "<C-j>", function() ui.nav_file(2) end)
keymap.set("n", "<C-k>", function() ui.nav_file(3) end)


-- git blame
keymap.set("n", "<leader>gb", vim.cmd.GitBlameToggle)
