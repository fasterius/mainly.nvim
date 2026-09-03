local M = {}

local config = require("mainly.config")

local KINDS = { "modules", "subworkflows", "workflows" }

---Get current file path
---@return string
local function get_path()
    return vim.fn.expand("%:p")
end

---Split full path string into parts
---@param path string
---@return string[]
local function split(path)
    local parts = {}
    for part in path:gmatch("[^/]+") do
        table.insert(parts, part)
    end
    return parts
end

---@class mainly.ComponentInfo
---@field kind string           One of "modules", "subworkflows" or "workflows"
---@field source string         Component source, e.g. "nf-core" or "local"
---@field name string           Top-level component name, e.g. "bcftools"
---@field subname string | nil  Submodule, e.g. "view"; nil if none
---@field is_test boolean       True for `main.nf.test`

---Parse full file path
---@param path string
---@return mainly.ComponentInfo | nil
function M.parse(path)
    -- Split path into parts and get the filename
    local parts = split(path)
    local filename = parts[#parts]
    local is_test = filename == "main.nf.test"

    -- Only parse for `main.nf` and `main.nf.test` files
    if filename ~= "main.nf" and not is_test then
        return nil
    end

    -- Find the kind anchor by searching from the end (i.e. the filename)
    local kind_idx
    for i = #parts - 1, 1, -1 do
        if vim.tbl_contains(KINDS, parts[i]) then
            kind_idx = i
            break
        end
    end

    -- Abort if no anchor is found
    if not kind_idx then
        return nil
    end

    -- Get the source index and check against allowed sources
    local source_idx = kind_idx + 1
    if source_idx > #parts then
        return nil
    end
    if not vim.tbl_contains(config.opts.allowed_sources, parts[source_idx]) then
        return nil
    end

    -- Specify which parts correspond to the component name
    local name_start = source_idx + 1
    local name_end = #parts - 1 -- exclude <filename>
    if is_test then
        -- Check that the segment between source and filename is `tests`
        if parts[name_end] ~= "tests" then
            return nil
        end
        name_end = name_end - 1 -- exclude `tests`
    end

    -- Check that start comes before end
    if name_start > name_end then
        return nil
    end

    -- Build the component name
    local name_parts = {}
    for i = name_start, name_end do
        table.insert(name_parts, parts[i])
    end

    return {
        kind = parts[kind_idx],
        source = parts[source_idx],
        name = name_parts[1],
        subname = name_parts[2],
        is_test = is_test,
    }
end

---Build a display label for a Nextflow component
---@return string
function M.build()
    local path = get_path()
    -- Get component information
    local component = M.parse(path)

    -- Return normal filename if filepath is not proper Nextflow component
    local filename = vim.fn.fnamemodify(path, ":t")
    if component == nil then
        return filename
    end

    -- Check for subname existance and start building label
    local label
    if component.subname ~= nil then
        label = component.name .. "/" .. component.subname
    else
        label = component.name
    end

    -- Expand label with "tests" if appropriate
    if component.is_test then
        label = label .. "/" .. "tests/" .. filename
    else
        label = label .. "/" .. filename
    end

    return label
end

return M
