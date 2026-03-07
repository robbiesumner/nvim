require("plugins.colorscheme")
require("plugins.lualine")
require("plugins.icons")
require("plugins.image")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.conform")
require("plugins.fzf")
require("plugins.which-key")
if vim.g.jupyter then
  require("plugins.molten")
end
