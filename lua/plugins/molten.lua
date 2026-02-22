vim.g.molten_image_provider = "image.nvim"
vim.g.molten_auto_open_output = false
vim.g.molten_virt_text_output = true
vim.g.molten_virt_lines_off_by_1 = true

-- jupytext
require("jupytext").setup({
  custom_language_formatting = {
    python = {
      style = "quarto",
      extension = "qmd",
      force_ft = "quarto",
    },
  },
})
require("quarto").setup({
  lspFeatures = {
    languages = { "python" },
    chunks = "all",
  },
  codeRunner = {
    enabled = true,
    default_method = "molten",
  },
})

-- keymaps
local molten_map = function(key, func, desc, mode)
  mode = mode or "n"
  vim.keymap.set(mode, "<leader>m" .. key, func, { desc = "[M]olten: " .. desc, silent = true })
end
molten_map("I", ":MoltenInfo<CR>", "[I]nfo")
molten_map("l", ":MoltenEvaluateLine<CR>", "Evaluate [L]ine")
molten_map("", ":<C-u>MoltenEvaluateVisual<CR>", "Evaluate visual selection", "v")
molten_map("e", ":MoltenEvaluateOperator<CR>", "[E]valuate")
molten_map("o", ":noautocmd MoltenEnterOutput<CR>", "Open [O]utput window")
molten_map("i", ":MoltenInit<CR>", "[I]nitialize Kernel")
molten_map("r", ":MoltenReevaluateCell<CR>", "[R]eevaluate cell")
molten_map("h", ":MoltenHideOutput<CR>", "[H]ide output window")
molten_map("d", ":MoltenDelete<CR>", "[D]elete cell")
molten_map("x", ":MoltenOpenInBrowser<CR>", "Open output in browser")

local runner = require("quarto.runner")
local quarto_map = function(key, func, desc, mode)
  mode = mode or "n"
  vim.keymap.set(mode, "<leader>q" .. key, func, { desc = "[Q]uarto: " .. desc, silent = true })
end
quarto_map("c", runner.run_cell, "Run [C]ell")
quarto_map("a", runner.run_above, "Run cell and [A]bove cells")
quarto_map("A", runner.run_all, "Run [A]ll cells")

-- import outputs from .ipynb
-- and activate kernel
local init_molten = function(e)
  vim.schedule(function()
    local kernels = vim.fn.MoltenAvailableKernels()
    local try_kernel_name = function()
      local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
      return metadata.kernelspec.name
    end
    local ok, kernel_name = pcall(try_kernel_name)
    if not ok or not vim.tbl_contains(kernels, kernel_name) then
      kernel_name = nil
      local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
      if venv ~= nil then
        kernel_name = string.match(venv, "/.+/(.+)")
      end
    end
    if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
      vim.cmd(("MoltenInit %s"):format(kernel_name))
    end
    vim.cmd("MoltenImportOutput")
  end)
end

vim.api.nvim_create_autocmd("BufAdd", {
  pattern = { "*.ipynb" },
  callback = init_molten,
})
-- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.ipynb" },
  callback = function(e)
    if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
      init_molten(e)
    end
  end,
})

-- export output cells to .ipynb
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.ipynb" },
  callback = function()
    if require("molten.status").initialized() == "Molten" then
      vim.cmd("MoltenExportOutput!")
    end
  end,
})
