# `mainly.nvim` for `main.nf`

A Neovim plugin for disambiguating between `main.nf` files in Nextflow by adding
the (grand)parent directory name to the filename, for use in your statusline.

## ✨ Features

- TODO

## 📚 Requirements

- Neovim >= `0.10.0`

## 📦 Installation

You can install `mainly.nvim` with your preferred package manager:

```lua
{
    "fasterius/mainly.nvim",
    config = true,
}
```

## 🚀 Usage

<!-- TODO: describe usage; see [the documentation](doc/mainly.nvim.nvim.txt)
for details. -->

`mainly.nvim` does not set any key mappings by default, but instead provides Lua
functions and user-commands that you can set key binds for:

- `hello`: TODO describe.

```lua
local mainly = require("mainly.nvim")
vim.keymap.set('n', '<localleader>h', mainly.hello)
```

## ⚙️ Configuration

`mainly.nvim` comes with the following options and their respective
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
    "fasterius/mainly.nvim.nvim",
    config = function()
        local mainly = require("mainly.nvim")
        mainly.setup({
            greeting = "Hello",
        })
        vim.keymap.set("n", "<localleader>h", mainly.hello)
    end,
}
```

## 📕 About

The core of `mainly.nvim` lived in my own Neovim configuration for quite some
time before I thought it was time to make it into a proper plugin. It is meant
to be used together with your statusline for working with Nextflow development,
where it disambiguates the abundantly available `main.nf` filename by added its
(grand)parent directory name to the filename.
