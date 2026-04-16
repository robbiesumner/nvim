-- filetypes
vim.filetype.add({
  filename = {
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["compose.yml"] = "yaml.docker-compose",
    ["compose.yaml"] = "yaml.docker-compose",
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    -- helper function
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("gd", vim.lsp.buf.definition, "[G]o to [D]efinition")
    map("K", vim.lsp.buf.hover, "Hover symbol")
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[N]ame symbol")
  end,
})

local capabilities = require("blink.cmp").get_lsp_capabilities()
local servers = {
  lua_ls = {},
  pyright = {},
  nixd = {},
  texlab = {},
  tinymist = {},
  yamlls = {},
  docker_language_server = {},
  docker_compose_language_service = {},
  cssls = {},
  qmlls = {
    cmd = { "qmlls", "-E" },
  },
  svelte = {},
  ts_ls = {},
  tailwindcss = {},
  eslint = {},
}

for name, server in pairs(servers) do
  server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end

-- special lua config magic
vim.lsp.config("lua_ls", {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath("config")
        and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = {
        version = "LuaJIT",
        path = { "lua/?.lua", "lua/?/init.lua" },
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
    })
  end,
  settings = {
    Lua = {},
  },
})

require("blink.cmp").setup({
  keymap = { preset = "default" },
  signature = { enabled = true },
  sources = {
    default = { "dictionary", "lsp", "path", "snippets", "buffer" },
    providers = {
      dictionary = {
        module = "blink-cmp-dictionary",
        name = "Dict",
        min_keyword_length = 2,
        max_items = 8,
        opts = {
          dictionary_files = function()
            if vim.bo.filetype == "lilypond" then
              return vim.fn.glob(vim.fn.expand("$LILYDICTPATH") .. "/*", true, true)
            end
          end,
        },
      },
    },
  },
})
