-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Noice =
{
    event = "VeryLazy",

    dependencies =
    {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },

    presets =
    {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
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
    -- Presets provide a sensible UI baseline without having to configure every route/view.
    return
    {
        presets = Noice.presets,
    }
end

local function Setup(_, opts)
    local noice = SafeRequire("noice")
    if noice == nil
    then
        return
    end

    -- Configure command-line UI, notifications, and LSP message routing.
    noice.setup(opts or {})
end

return
{
    {
        "folke/noice.nvim",
        event = Noice.event,
        dependencies = Noice.dependencies,

        opts = function()
            return BuildOpts()
        end,

        config = function(_, opts)
            Setup(_, opts)
        end,
    },
}
