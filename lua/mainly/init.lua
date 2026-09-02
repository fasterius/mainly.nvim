local M = {}

---@class mainly.Opts
---@field allowed_sources? table

-- Default configuration
---@type mainly.Opts
M.opts = {
    allowed_sources = { "local", "nf-core" },
}

---Setup with options and validation
---@param opts mainly.Opts | nil
function M.setup(opts)
    opts = opts or {}
    vim.validate("opts", opts, "table")
    vim.validate("opts.allowed_sources", opts.allowed_sources, "table", true)
    M.opts = vim.tbl_extend("force", M.opts, opts)
end

-- TODO: replace with your plugin's real public functions. Keep argument
-- handling here minimal; once there's more than a trivial amount of logic
-- for a given concern, split it into its own submodule (see `util.lua` for
-- an example shared helper)

return M
