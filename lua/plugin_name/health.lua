local M = {}

-- The complete list of known configuration keys.
-- TODO: keep this in sync with `plugin_name.Opts` in `init.lua`.
local known_opts = {
    greeting = true,
}

---Run plugin_name's healthcheck
---Report on the presence of the plugin's requirements, and flag any
---unrecognised configuration key set via `setup()`. Auto-discovered by
---`:checkhealth` from this file's location (:help health-dev) -- no
---separate registration needed.
function M.check()
    vim.health.start("plugin-name.nvim")

    -- TODO: set this to the same version required in `plugin/plugin-name.lua`.
    if vim.fn.has("nvim-0.10.0") == 1 then
        vim.health.ok("Neovim version is >= 0.10.0")
    else
        vim.health.error("Neovim version is too old", "plugin-name.nvim requires at least Neovim v0.10.0")
    end

    -- TODO: if your plugin depends on another plugin or an external tool,
    -- check for it here, e.g.:
    --
    -- if vim.fn.exists(":SomeCommand") == 2 then
    --     vim.health.ok("some-dependency is installed")
    -- else
    --     vim.health.error(
    --         "some-dependency does not appear to be installed",
    --         "Install https://github.com/example/some-dependency"
    --     )
    -- end

    local opts = require("plugin_name").opts
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
            "Check for typos; see |plugin-name.configuration| for the supported options"
        )
    end
end

return M
