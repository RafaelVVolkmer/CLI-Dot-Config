-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local WhichKey =
{
    event = "VeryLazy",
    opts = {},
}

local function BuildSpec()
    return
    {
        "folke/which-key.nvim",
        event = WhichKey.event,

        -- Keep opts as a function so it can be extended safely later.
        opts = function()
            return WhichKey.opts
        end,
    }
end

return
{
    BuildSpec(),
}
