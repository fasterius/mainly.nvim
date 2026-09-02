local M = {}

---@class plugin_name.Opts
---@field greeting? string

-- Default configuration.
-- TODO: replace with your plugin's real default options.
---@type plugin_name.Opts
M.opts = {
    greeting = "Hello",
}

---Setup with options and validation
---setup() should only merge and validate configuration -- initialisation
---(commands, keymaps, autocmds) belongs in `plugin/plugin-name.lua`, so
---the plugin works whether or not a user ever calls this (:help
---lua-plugin-init).
---@param opts plugin_name.Opts|nil
function M.setup(opts)
    opts = opts or {}
    vim.validate("opts", opts, "table")
    -- TODO: add one call per option, matching the fields declared in
    -- `plugin_name.Opts` above.
    vim.validate("opts.greeting", opts.greeting, "string", true)
    M.opts = vim.tbl_extend("force", M.opts, opts)
end

-- TODO: replace with your plugin's real public functions. Keep argument
-- handling here minimal; once there's more than a trivial amount of logic
-- for a given concern, split it into its own submodule (see `util.lua` for
-- an example shared helper)

---Example user-facing function -- replace or remove me
function M.hello()
    vim.notify(M.opts.greeting .. " from plugin_name!", vim.log.levels.INFO)
end

return M
