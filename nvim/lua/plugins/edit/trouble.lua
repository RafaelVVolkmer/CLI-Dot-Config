-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Trouble =
{
    command = "Trouble",

    dependencies =
    {
        "nvim-tree/nvim-web-devicons",
    },

    opts = {},
}

local function BuildSpec()
    return
    {
        "folke/trouble.nvim",
        cmd = Trouble.command,
        dependencies = Trouble.dependencies,

        -- Use a function so options can be extended conditionally later (OS, project, etc.).
        opts = function()
            return Trouble.opts
        end,
    }
end

return
{
    BuildSpec(),
}
