-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Flash =
{
    event = "VeryLazy",
    opts = {},
}

local function BuildSpec()
    return
    {
        "folke/flash.nvim",
        event = Flash.event,

        -- Keep opts as a function so it can be extended safely later.
        opts = function()
            return Flash.opts
        end,
    }
end

return
{
    BuildSpec(),
}
