local M = {}

local label = require("mainly.label")

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

---Get final formatted filename
---@return string
function M.filename()
    return label.format(label.path())
end

return M
