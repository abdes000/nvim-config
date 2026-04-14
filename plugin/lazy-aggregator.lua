-- File: lua/plugins/init.lua
-- Collects all plugin specs from nested folders

local M = {}

function M.load()
  local specs = {}

  -- glob all Lua files under lua/plugins/** using vim.fn
  local files = vim.fn.globpath(vim.fn.stdpath("config") .. "/lua/plugins", "**/*.lua", false, true)

  for _, file in ipairs(files) do
    -- strip path to get module name
    local rel = file:gsub("^" .. vim.fn.stdpath("config") .. "/lua/", "")
    rel = rel:gsub("%.lua$", ""):gsub("/", ".") -- convert to require path

    local ok, mod = pcall(require, rel)
    if ok then
      if vim.tbl_islist(mod) then
        vim.list_extend(specs, mod) -- if file returns a list of specs
      else
        table.insert(specs, mod)    -- if file returns a single spec
      end
    else
      vim.notify("Failed to load plugin spec: " .. rel, vim.log.levels.ERROR)
    end
  end

  return specs
end

return M
