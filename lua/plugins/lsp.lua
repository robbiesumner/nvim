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
  pyright = {
    settings = {
      python = {
        analysis = {
          diagnosticSeverityOverrides = {
            -- for notebooks: leaving value at the end to be printed
            reportUnusedExpression = "none",
          },
        },
      },
    },
  },
  nixd = {},
  yamlls = {},
  docker_language_server = {},
  cssls = {},
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
vim.lsp.enable("lua_ls")

require("blink.cmp").setup({
  sources = {
    default = { "lsp", "path", "snippets" },
    signature = { enabled = true },
  },
})
