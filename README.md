# 🏷️ Mainly for `main.nf`

> Disambiguating `main.nf` and `main.nf.test` files in your statusline

When working with Nextflow pipelines, many files are often named `main.nf` by
convention: one per module, subworkflow and pipeline. In a statusline showing
just the filename, they're indistinguishable. `mainly.nvim` fixes this by
converting each `main.nf` filename to a contextual label based on its component
(module, subworkflow) or pipeline name, for use in your statusline:

| File path                                   | Statusline label              |
| ------------------------------------------- | ----------------------------- |
| `modules/nf-core/fastqc/main.nf`            | `fastqc/main.nf`              |
| `modules/nf-core/bcftools/view/main.nf`     | `bcftools/view/main.nf`       |
| `modules/local/mymodule/tests/main.nf.test` | `mymodule/tests/main.nf.test` |
| `~/rnaseq/main.nf`                          | `rnaseq/main.nf`              |

## ✨ Features

- Disambiguation of `main.nf` and `main.nf.test` files through structured labels
- Validation of component and pipeline directory structure
- Configurable list of allowed component sources (`local` and `nf-core` by
  default)
- Optionally include the full component path (_e.g._ `modules/nf-core/...`) in
  the label

## 📚 Requirements

- Neovim >= `0.10.0`

## 📦 Installation

You can install `mainly.nvim` with your preferred package manager:

```lua
{
    "fasterius/mainly.nvim",
}
```

No setup is required for the defaults; pass `opts` or call `setup()` to
override them.

## 🚀 Usage

`mainly.nvim` can be used together with your statusline, intended to replace the
filename component of your statusline. The `mainly.filename()` function is what
should be used, and an extremely minimal example is here given for the
[Lualine](https://github.com/nvim-lualine/lualine.nvim) plugin:

```lua
local mainly_filename = require("mainly").filename
require("lualine").setup({
    sections = {
        lualine_c = { mainly_filename },
    },
    inactive_sections = {
        lualine_c = { mainly_filename },
    }
})
```

The `mainly.filename()` function returns a string, so it should be able to be
integrated into whatever variant of statusline you prefer, whether from a plugin
or by using Neovim's built-in functionality.

## ⚙️ Configuration

`mainly.nvim` comes with the following options and their respective defaults:

```lua
{
    -- The allowed sources for components, used for validating the final
    -- filename label structure.
    allowed_sources = { "local", "nf-core" },

    -- Whether to include the full component path for the label, _i.e._
    -- including `<component>/<source>` as a prefix for `<name>/main.nf`.
    include_component = false,
}
```

A complete installation and configuration might look something like this:

```lua
{
    "fasterius/mainly.nvim",
    config = function()
        require("mainly").setup({
            allowed_sources = { "local", "nf-core", "my_source" },
            include_component = true,
        })
    end,
}
```

## 📕 About

The core of `mainly.nvim` lived in my own Neovim configuration for quite some
time before I thought it was time to make it into a proper plugin. It is meant
to be used together with your statusline; a niche use case for Nextflow
development with Neovim. I hope it's as useful to you as it has been to me!
