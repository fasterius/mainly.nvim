-- TODO: rename this file to match your plugin's repo name, e.g.
-- `plugin/my-plugin.lua` for a plugin named `my-plugin.nvim`.
--
-- This file is run unconditionally at Neovim startup for every plugin on
-- 'runtimepath' (:help lua-plugin-lazy) -- that's intentional, so it must
-- stay small and must NOT eagerly `require()` the rest of the plugin
-- (:help lua-plugin-defer-require). Only command/keymap/autocmd
-- declarations belong here; each callback does its own `require()`.

-- Prevents this file from doing anything if it's sourced more than once,
-- and lets a user opt out of the plugin entirely by setting this variable
-- themselves before it loads (:help usr_41.txt, "NOT LOADING").
-- TODO: rename `loaded_plugin_name` to match your plugin's module name.
if vim.g.loaded_plugin_name then
    return
end
vim.g.loaded_plugin_name = true

-- TODO: set this to the actual minimum Neovim version your plugin needs.
-- 0.10.0 is used here because that's the version `vim.health.start/ok/
-- warn/error` (used in `lua/plugin_name/health.lua`) requires.
if vim.fn.has("nvim-0.10.0") ~= 1 then
    vim.notify("plugin-name.nvim requires at least Neovim v0.10.0.", vim.log.levels.ERROR)
    return
end

-- TODO: replace with your plugin's real commands. Each callback requires
-- the module lazily, so the module itself is only loaded the first time a
-- command actually runs, not unconditionally at startup.
vim.api.nvim_create_user_command("PluginNameHello", function()
    require("plugin_name").hello()
end, { desc = "Example command -- replace or remove me" })
