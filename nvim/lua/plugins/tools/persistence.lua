-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Persistence =
{
    event = "BufReadPre",
    opts = {},
}

local function BuildSpec()
    return
    {
        "folke/persistence.nvim",
        event = Persistence.event,

        -- Keep opts as a function so it can be extended safely later.
        opts = function()
            return Persistence.opts
        end,
    }
end

return
{
    BuildSpec(),
}
