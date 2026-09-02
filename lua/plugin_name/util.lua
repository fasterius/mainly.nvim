-- Example shared-helper submodule. Split logic out into files like this
-- one (and reference them from `init.lua`) once a concern grows past a
-- couple of lines.
--
-- TODO: delete this file if you don't need a shared helper like this yet.

local M = {}

---Error handling
---Handle plugin errors by printing an error message and returning `nil` so
---that execution can gracefully complete.
---@param message string the error message
---@return nil
function M.raise_error(message)
    vim.notify("Error: " .. message, vim.log.levels.ERROR)
    return nil
end

return M
