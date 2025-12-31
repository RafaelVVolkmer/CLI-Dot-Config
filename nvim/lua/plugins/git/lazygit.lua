-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local LazyGit =
{
    commands =
    {
        "LazyGit",
        "LazyGitCurrentFile",
        "LazyGitConfig",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },

    dependencies =
    {
        "nvim-lua/plenary.nvim",
    },
}

local function BuildSpec()
    return
    {
        "kdheepak/lazygit.nvim",
        cmd = LazyGit.commands,
        dependencies = LazyGit.dependencies,
    }
end

return
{
    BuildSpec(),
}
