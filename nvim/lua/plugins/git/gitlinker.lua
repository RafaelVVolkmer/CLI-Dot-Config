-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Gitlinker =
{
    event = "VeryLazy",

    dependencies =
    {
        "nvim-lua/plenary.nvim",
    },

    opts = {},
}

local function BuildSpec()
    return
    {
        "ruifm/gitlinker.nvim",
        event = Gitlinker.event,
        dependencies = Gitlinker.dependencies,

        -- Keep it as a function so it's easy to extend later without refactoring.
        opts = function()
            return Gitlinker.opts
        end,
    }
end

return
{
    BuildSpec(),
}
