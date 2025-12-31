-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Notify =
{
    event = "VeryLazy",

    background =
    {
        color = "#000000",
        hl_group = "NotifyBackground",
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

local function EnsureBackgroundHighlight()
    -- Ensure the highlight group exists so notifications have a consistent background.
    vim.api.nvim_set_hl(0, Notify.background.hl_group,
    {
        bg = Notify.background.color,
    })
end

local function SetupNotify()
    local notify = SafeRequire("notify")
    if notify == nil
    then
        return
    end

    notify.setup(
    {
        background_colour = Notify.background.color,
    })

    -- Route Neovim notifications through nvim-notify.
    vim.notify = notify

    EnsureBackgroundHighlight()
end

return
{
    {
        "rcarriga/nvim-notify",
        event = Notify.event,

        config = function()
            SetupNotify()
        end,
    },
}
