-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Bufferline =
{
    version = "*",
    event = "VimEnter",

    dependencies =
    {
        "nvim-tree/nvim-web-devicons",
    },

    options =
    {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        show_close_icon = false,
        separator_style = "slant",

        offsets =
        {
            {
                filetype = "neo-tree",
                text = "Explorer",
                separator = true,
            },
        },
    },

    showtabline_value = 2,
}

local function SafeRequire(module_name)
    local ok, mod = pcall(require, module_name)
    if ok
    then
        return mod
    end

    return nil
end

local function BuildOpts()
    -- Keep the options table separated so it stays easy to extend.
    return
    {
        options = Bufferline.options,
    }
end

local function ApplyEditorOptions()
    -- Always show the tabline when using bufferline.
    vim.opt.showtabline = Bufferline.showtabline_value
end

local function Setup(_, opts)
    local bufferline = SafeRequire("bufferline")
    if bufferline == nil
    then
        return
    end

    bufferline.setup(opts or {})
    ApplyEditorOptions()
end

return
{
    {
        "akinsho/bufferline.nvim",
        version = Bufferline.version,
        event = Bufferline.event,
        dependencies = Bufferline.dependencies,

        opts = function()
            return BuildOpts()
        end,

        config = function(_, opts)
            Setup(_, opts)
        end,
    },
}
