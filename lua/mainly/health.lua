local M = {}

-- Configuration
local known_opts = {
    allowed_sources = { "local", "nf-core" },
}

---Health check
function M.check()
    vim.health.start("mainly.nvim")

    -- Check require Neovim version
    if vim.fn.has("nvim-0.10.0") == 1 then
        vim.health.ok("Neovim version is >= 0.10.0")
    else
        vim.health.error("Neovim version is too old", "mainly.nvim requires at least Neovim v0.10.0")
    end

    -- Check for unknown configuration options
    local opts = require("mainly").opts
    local unknown = {}
    for key in pairs(opts) do
        if not known_opts[key] then
            table.insert(unknown, key)
        end
    end
    if #unknown == 0 then
        vim.health.ok("No unrecognised configuration options")
    else
        vim.health.warn(
            "Unrecognised configuration option(s): " .. table.concat(unknown, ", "),
            "Check for typos; see |mainly.configuration| for the supported options"
        )
    end
end

return M
