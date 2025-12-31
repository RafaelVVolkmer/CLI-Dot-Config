-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Colorizer =
{
    events =
    {
        "BufReadPre",
        "BufNewFile",
    },

    enabled_filetypes =
    {
        "*",
    },

    opts =
    {
        RGB = true,
        RRGGBB = true,
        RRGGBBAA = true,

        rgb_fn = true,
        hsl_fn = true,

        css = true,
        css_fn = true,

        tailwind = true,

        names = false,
        mode = "background",
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

local function EnableTrueColor()
    -- Required for accurate highlight rendering in terminals that support it.
    vim.opt.termguicolors = true
end

local function SetupColorizer()
    local colorizer = SafeRequire("colorizer")
    if colorizer == nil
    then
        return
    end

    EnableTrueColor()

    -- Apply to all filetypes (or adjust `enabled_filetypes` if you prefer a whitelist).
    colorizer.setup(Colorizer.enabled_filetypes, Colorizer.opts)
end

return
{
    {
        "catgoose/nvim-colorizer.lua",
        event = Colorizer.events,

        config = function()
            SetupColorizer()
        end,
    },
}
