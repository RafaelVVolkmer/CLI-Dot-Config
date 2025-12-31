-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Harpoon =
{
    name = "harpoon",
    branch = "harpoon2",

    dependencies =
    {
        "nvim-lua/plenary.nvim",
    },

    opts = {},
}

local function BuildSpec()
    return
    {
        "ThePrimeagen/harpoon",
        name = Harpoon.name,
        branch = Harpoon.branch,
        dependencies = Harpoon.dependencies,

        -- Keep opts as a function so it can evolve (keymaps, UI, integrations).
        opts = function()
            return Harpoon.opts
        end,
    }
end

return
{
    BuildSpec(),
}
