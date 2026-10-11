vim.pack.add { { src = 'https://github.com/chomosuke/typst-preview.nvim', version = vim.version.range '1.*' } }
require('typst-preview').setup {}

vim.keymap.set('n', '<leader>tp', '<cmd>TypstPreviewToggle<CR>', { desc = '[T]oggle Typst [P]review' })
vim.keymap.set('n', '<leader>tc', '<cmd>TypstPreviewFollowCursorToggle<CR>', { desc = '[T]oggle Typst [C]ursor follow' })
