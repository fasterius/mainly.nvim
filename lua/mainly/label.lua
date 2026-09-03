local M = {}

local config = require("mainly.config")

-- Valid component names
local KINDS = { "modules", "subworkflows" }

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
---@field kind string           "modules"|"subworkflows"|"pipelines"
---@field source string | nil   Component source; nil for pipeline root
---@field name string | nil     Top-level component name; nil for pipeline root
---@field subname string | nil  Submodule; nil for pipeline root or when missing
---@field pipeline string | nil Root pipeline; nil for all other components
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

    -- No component found: check for test files and pipeline root
    if not kind_idx then
        -- Abort if test files are found outside components
        if is_test then
            return nil
        end
        -- Abort if no pipeline root is found, otherwise return pipeline root
        if #parts < 2 then
            return nil
        end
        return {
            kind = "pipelines",
            pipeline = parts[#parts - 1],
            is_test = false,
        }
    end

    -- Get the source index
    local source_idx = kind_idx + 1
    if source_idx > #parts then
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

---Format a display label for a Nextflow component
---@return string
function M.format()
    local path = get_path()
    -- Get component information
    local component = M.parse(path)

    -- Not a component or root pipeline: return normal filename
    local filename = vim.fn.fnamemodify(path, ":t")
    if component == nil then
        return filename
    end

    -- Root pipeline: return pipeline name + filename
    if component.kind == "pipelines" then
        return component.pipeline .. "/" .. filename
    end

    -- Component: check that component source is allowed
    if not vim.tbl_contains(config.opts.allowed_sources, component.source) then
        return filename
    end

    -- Component: check for subname existence and start formatting the label
    local label
    if component.subname ~= nil then
        label = component.name .. "/" .. component.subname
    else
        label = component.name
    end

    -- Component: expand label with "/tests/" (if appropriate) and return
    if component.is_test then
        label = label .. "/tests/" .. filename
    else
        label = label .. "/" .. filename
    end
    return label
end

return M
