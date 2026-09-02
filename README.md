# plugin-name.nvim

<!-- TODO: one-sentence description of what this plugin does. -->

## ✨ Features

- TODO

## 📚 Requirements

- Neovim >= TODO
- TODO: any other dependencies

## 📦 Installation

You can install the plugin with your preferred package manager:

```lua
{
    "yourname/plugin-name.nvim",
    config = true,
}
```

## 🚀 Usage

<!-- TODO: describe usage; see [the documentation](doc/plugin-name.nvim.txt)
for details. -->

`plugin-name` does not set any key mappings by default, but instead
provides Lua functions and user-commands that you can set key binds for:

- `hello`: TODO describe.

```lua
local plugin = require("plugin_name")
vim.keymap.set('n', '<localleader>h', plugin.hello)
```

## ⚙️ Configuration

`plugin-name` comes with the following options and their respective
defaults:

```lua
{
    -- TODO: describe this option.
    greeting = "Hello",
}
```

A complete installation and configuration might look something like this:

```lua
{
    "yourname/plugin-name.nvim",
    config = function()
        local plugin = require("plugin_name")
        plugin.setup({
            greeting = "Hello",
        })
        vim.keymap.set("n", "<localleader>h", plugin.hello)
    end,
}
```

## 📕 About

<!-- TODO: why does this plugin exist; what problem does it solve. -->
