-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Treesitter =
{
    events =
    {
        "BufReadPost",
        "BufNewFile",
    },

    build_cmd = ":TSUpdate",

    ensure_installed =
    {
        "c",
        "cpp",
        "lua",
        "bash",
        "vim",
        "vimdoc",
        "json",
    },

    features =
    {
        highlight = true,
        indent = true,
    },
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
    -- Keep Treesitter configuration centralized for easy maintenance.
    return
    {
        ensure_installed = Treesitter.ensure_installed,

        highlight =
        {
            enable = Treesitter.features.highlight,
        },

        indent =
        {
            enable = Treesitter.features.indent,
        },
    }
end

local function Setup()
    local configs = SafeRequire("nvim-treesitter.configs")
    if configs == nil
    then
        return
    end

    -- Treesitter is optional; avoid hard failures if it's not available.
    configs.setup(BuildOpts())
end

return
{
    {
        "nvim-treesitter/nvim-treesitter",
        event = Treesitter.events,
        build = Treesitter.build_cmd,

        config = function()
            Setup()
        end,
    },
}
