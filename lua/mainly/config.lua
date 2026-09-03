local M = {}

---@class mainly.Opts
---@field allowed_sources? table
---@field include_component? boolean

-- Default configuration
---@type mainly.Opts
M.defaults = {
    allowed_sources = { "local", "nf-core" },
    include_component = false,
}
M.opts = vim.deepcopy(M.defaults)

---Setup with options and validation
---@param opts mainly.Opts | nil
function M.setup(opts)
    opts = opts or {}
    vim.validate("opts", opts, "table")
    vim.validate("opts.allowed_sources", opts.allowed_sources, "table", true)
    vim.validate("opts.include_component", opts.include_component, "boolean", true)
    M.opts = vim.tbl_extend("force", M.opts, opts)
end

return M
