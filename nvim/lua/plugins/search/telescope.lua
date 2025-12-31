-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Telescope =
{
    branch = "0.1.x",
    command = "Telescope",

    dependencies =
    {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
    },

    ui =
    {
        prompt_prefix = "   ",
        selection_caret = "❯ ",
        path_display = { "smart" },
    },

    file_ignore_patterns =
    {
        "%.o$",
        "%.a$",
        "%.out$",
        "%.class$",
        "node_modules/",
        "%.git/",
        "dist/",
        "build/",
    },
}

local function SafeRequire(module_name)
    local ok, mod = pcall(require, module_name)
    if ok
    then
        return mod
    end

    return nil
end

local function BuildDefaults()
    -- Keep UI and ignore patterns centralized for easy maintenance.
    return
    {
        prompt_prefix = Telescope.ui.prompt_prefix,
        selection_caret = Telescope.ui.selection_caret,
        path_display = Telescope.ui.path_display,
        file_ignore_patterns = Telescope.file_ignore_patterns,
    }
end

local function BuildOpts()
    return
    {
        defaults = BuildDefaults(),
    }
end

local function Setup(_, opts)
    local telescope = SafeRequire("telescope")
    if telescope == nil
    then
        return
    end

    -- Apply Telescope configuration only when the module is available.
    telescope.setup(opts or {})
end

return
{
    {
        "nvim-telescope/telescope.nvim",
        branch = Telescope.branch,
        cmd = Telescope.command,
        dependencies = Telescope.dependencies,

        opts = function()
            return BuildOpts()
        end,

        config = function(_, opts)
            Setup(_, opts)
        end,
    },
}
