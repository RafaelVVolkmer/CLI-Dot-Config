-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Codex =
{
    name = "codex",

    commands =
    {
        "Codex",
        "CodexToggle",
    },

    ui =
    {
        panel = false,
        border = "rounded",

        -- Conform to plugin convention: use 0..1 as a percentage of the editor.
        width = 0.85,
        height = 0.85,
    },

    autoinstall = true,

    keymaps =
    {
        -- Let the user decide their own toggle mapping elsewhere (WhichKey, leader, etc.).
        toggle = nil,

        -- Fast exit for a floating UI.
        quit = "<C-q>",
    },
}

local function BuildOpts()
    -- Centralized option construction keeps the plugin spec clean and easy to extend.
    return
    {
        panel = Codex.ui.panel,
        border = Codex.ui.border,
        width = Codex.ui.width,
        height = Codex.ui.height,
        autoinstall = Codex.autoinstall,

        keymaps =
        {
            toggle = Codex.keymaps.toggle,
            quit = Codex.keymaps.quit,
        },
    }
end

return
{
    {
        "johnseth97/codex.nvim",
        name = Codex.name,
        cmd = Codex.commands,

        opts = function()
            return BuildOpts()
        end,
    },
}
