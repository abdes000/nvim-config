-- File: lua/plugins/init.lua
-- Aggregator for all plugin modules in lua/plugins/*

local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"
local plugins = {}

-- Scan subfolders and files under lua/plugins
for _, file in ipairs(vim.fn.glob(plugin_dir .. "/*/*.lua", 0, 1)) do
  local rel = file:sub(#plugin_dir + 2, -5) -- strip path and .lua
  local mod = "plugins." .. rel:gsub("/", ".")
  local ok, spec = pcall(require, mod)
  if ok and spec then
    table.insert(plugins, spec)
  else
    vim.notify("Failed to load plugin spec: " .. mod, vim.log.levels.WARN)
  end
end

-- Initialize lazy.nvim with collected specs
require("lazy").setup(plugins)
