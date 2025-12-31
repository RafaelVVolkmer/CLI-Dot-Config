-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Windline =
{
    event = "VimEnter",

    dependencies =
    {
        "lewis6991/gitsigns.nvim",
    },

    terminal_palette =
    {
        terminal_color_4 = "#ff9aa2",
        terminal_color_12 = "#ffb3ba",

        terminal_color_6 = "#ffd1dc",
        terminal_color_14 = "#ffe5ea",
    },

    sample_module = "wlsample.wind",
}

local function SafeRequire(module_name)
    local ok, mod = pcall(require, module_name)
    if ok
    then
        return mod
    end

    return nil
end

local function ApplyTerminalPalette()
    -- Windline sample themes read from terminal_color_* globals.
    -- Keeping these values centralized makes it easy to tweak the palette later.
    for key, value in pairs(Windline.terminal_palette)
    do
        vim.g[key] = value
    end
end

local function LoadSampleTheme()
    -- Load the sample windline configuration (provided by windline.nvim).
    SafeRequire(Windline.sample_module)
end

local function Setup()
    ApplyTerminalPalette()
    LoadSampleTheme()
end

return
{
    {
        "windwp/windline.nvim",
        event = Windline.event,
        dependencies = Windline.dependencies,

        config = function()
            Setup()
        end,
    },
}
