local M = {}

---Get current file path
---@return string
function M.path()
    return vim.fn.expand("%:p")
end

---Format file path string
---@param path string
---@return string
function M.format(path)
    local filename = vim.fn.fnamemodify(path, ":t")
    if filename == "main.nf" then
        local parent = vim.fn.fnamemodify(path, ":h:t")
        return parent .. "/" .. filename
    elseif filename == "main.nf.test" then
        local parent = vim.fn.fnamemodify(path, ":h:t")
        local grandparent = vim.fn.fnamemodify(path, ":h:h:t")
        return grandparent .. "/" .. parent .. "/" .. filename
    else
        return filename
    end
end

return M
