-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local ToggleTerm =
{
    command = "ToggleTerm",

    opts =
    {
        shade_terminals = true,
        direction = "float",

        float_opts =
        {
            border = "rounded",
        },
    },
}

local function BuildSpec()
    return
    {
        "akinsho/toggleterm.nvim",
        cmd = ToggleTerm.command,

        -- Keep opts as a function so it can be extended safely later.
        opts = function()
            return ToggleTerm.opts
        end,
    }
end

return
{
    BuildSpec(),
}
