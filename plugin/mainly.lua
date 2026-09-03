-- Prevent multiple plugin loads
if vim.g.loaded_mainly then
    return
end
vim.g.loaded_mainly = true

-- Check for required Neovim version
if vim.fn.has("nvim-0.11.0") ~= 1 then
    vim.notify("mainly.nvim requires at least Neovim v0.11.0.", vim.log.levels.ERROR)
    return
end
