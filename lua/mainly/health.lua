local M = {}

local config = require("mainly.config")

-- Health check
function M.check()
    vim.health.start("mainly.nvim")

    -- Check required Neovim version
    if vim.fn.has("nvim-0.11.0") == 1 then
        vim.health.ok("Neovim version is >= 0.11.0")
    else
        vim.health.error("Neovim version is too old", "mainly.nvim requires at least Neovim v0.11.0")
    end

    -- Check for unknown configuration options
    local unknown = {}
    for key in pairs(config.opts) do
        if config.defaults[key] == nil then
            table.insert(unknown, key)
        end
    end
    if #unknown == 0 then
        vim.health.ok("No unrecognised configuration options")
    else
        vim.health.warn(
            "Unrecognised configuration option(s): " .. table.concat(unknown, ", "),
            "See |mainly.configuration| for the supported options"
        )
    end
end

return M
