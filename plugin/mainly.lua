-- Prevent multiple plugin loads
if vim.g.loaded_mainly then
    return
end
vim.g.loaded_mainly = true

-- Check for required Neovim version
if vim.fn.has("nvim-0.10.0") ~= 1 then
    vim.notify("mainly.nvim requires at least Neovim v0.10.0.", vim.log.levels.ERROR)
    return
end

-- TODO: replace with your plugin's real commands. Each callback requires
-- the module lazily, so the module itself is only loaded the first time a
-- command actually runs, not unconditionally at startup.
-- vim.api.nvim_create_user_command("PluginNameHello", function()
--     require("mainly").hello()
-- end, { desc = "Example command -- replace or remove me" })
