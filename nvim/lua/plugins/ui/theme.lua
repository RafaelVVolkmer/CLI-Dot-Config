-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Jellybeans =
{
    lazy = false,
    priority = 1000,

    colorscheme = "jellybeans",

    opts =
    {
        transparent = true,
        italics = true,
        bold = true,
    },

    transparency =
    {
        -- Groups that should keep a fully transparent background.
        groups =
        {
            "Normal",
            "NormalNC",
            "EndOfBuffer",
            "SignColumn",
            "NormalFloat",
            "FloatBorder",
            "MsgArea",
            "WinSeparator",
            "VertSplit",

            "NeoTreeNormal",
            "NeoTreeNormalNC",
            "NeoTreeEndOfBuffer",
            "NeoTreeSignColumn",
            "NeoTreeFloatNormal",
            "NeoTreeFloatBorder",

            "AerialNormal",
            "AerialNormalNC",
            "AerialLine",
            "AerialGuide",
            "AerialFloatNormal",
            "AerialFloatBorder",

            "BufferLineFill",
            "BufferLineBackground",

            "Pmenu",
            "PmenuSel",
        },

        augroup_name = "UserJellybeansTransparency",
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

local function ApplyTransparency()
    -- Enforce transparent backgrounds for selected highlight groups.
    for _, group in ipairs(Jellybeans.transparency.groups)
    do
        pcall(vim.api.nvim_set_hl, 0, group,
        {
            bg = "NONE",
        })
    end
end

local function SetupAutocmds()
    local group = vim.api.nvim_create_augroup(Jellybeans.transparency.augroup_name, { clear = true })

    vim.api.nvim_create_autocmd("ColorScheme",
    {
        group = group,

        callback = function()
            -- Schedule to ensure highlights are available after the scheme is applied.
            vim.schedule(ApplyTransparency)
        end,
    })

    vim.api.nvim_create_autocmd("VimEnter",
    {
        group = group,

        callback = function()
            -- Re-apply on startup (some plugins set highlights late).
            vim.schedule(ApplyTransparency)
        end,
    })
end

local function SetupTheme(opts)
    local jellybeans = SafeRequire("jellybeans")
    if jellybeans ~= nil
    then
        -- Configure the theme if the module exists (some colorschemes are only Vimscript).
        pcall(function()
            jellybeans.setup(opts or {})
        end)
    end

    -- Apply the colorscheme even if setup() is unavailable.
    pcall(vim.cmd.colorscheme, Jellybeans.colorscheme)

    ApplyTransparency()
    SetupAutocmds()
end

return
{
    {
        "wtfox/jellybeans.nvim",
        lazy = Jellybeans.lazy,
        priority = Jellybeans.priority,

        opts = function()
            return Jellybeans.opts
        end,

        config = function(_, opts)
            SetupTheme(opts)
        end,
    },
}
