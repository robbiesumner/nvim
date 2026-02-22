for _, path in ipairs(vim.fn.globpath(vim.o.runtimepath, "lua/plugins/*.lua", false, true)) do
  local name = vim.fn.fnamemodify(path, ":t:r")
  if name ~= "init" then
    require("plugins." .. name)
  end
end
