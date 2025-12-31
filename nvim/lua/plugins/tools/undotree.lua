-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Undotree =
{
    command = "UndotreeToggle",

    globals =
    {
        undotree_WindowLayout = 2,
        undotree_SplitWidth = 30,
        undotree_SetFocusWhenToggle = 1,
        undotree_DiffAutoOpen = 1,
        undotree_DiffpanelHeight = 8,
    },
}

local function ApplyGlobals()
    -- Undotree is configured via global variables (vimscript-style).
    for key, value in pairs(Undotree.globals)
    do
        vim.g[key] = value
    end
end

local function BuildSpec()
    return
    {
        "mbbill/undotree",
        cmd = Undotree.command,

        init = function()
            ApplyGlobals()
        end,
    }
end

return
{
    BuildSpec(),
}
