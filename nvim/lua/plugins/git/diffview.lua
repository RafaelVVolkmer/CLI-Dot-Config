-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Diffview =
{
    commands =
    {
        "DiffviewOpen",
        "DiffviewClose",
    },

    dependencies =
    {
        "nvim-lua/plenary.nvim",
    },
}

local function BuildSpec()
    return
    {
        "sindrets/diffview.nvim",
        cmd = Diffview.commands,
        dependencies = Diffview.dependencies,
    }
end

return
{
    BuildSpec(),
}
