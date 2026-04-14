local function load_plugin_modules()
  local root = vim.fn.stdpath("config") .. "/lua/plugins"
  local files = vim.fn.globpath(root, "**/*.lua", true, true)
  local plugins = {}
  local prefix = root .. "/"

  for _, file in ipairs(files) do
    if file:sub(-8) ~= "init.lua" then
      local rel = file:sub(#prefix + 1, -5)
      rel = rel:gsub("\\", ".")
      rel = rel:gsub("/", ".")
      table.insert(plugins, require("plugins." .. rel))
    end
  end

  return plugins
end

return load_plugin_modules()
