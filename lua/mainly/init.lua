local M = {}

local label = require("mainly.label")
local config = require("mainly.config")

---Setup with user options
---@param opts mainly.Opts | nil
function M.setup(opts)
    config.setup(opts)
end

---Get final formatted filename
---@return string
function M.filename()
    return label.build()
end

return M
