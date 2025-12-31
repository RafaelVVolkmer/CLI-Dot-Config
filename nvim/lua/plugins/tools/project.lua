-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Project =
{
    event = "VeryLazy",

    detection_methods =
    {
        "pattern",
        "lsp",
    },

    patterns =
    {
        ".git",
        "Makefile",
        "CMakeLists.txt",
        "compile_commands.json",
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

local function BuildOpts()
    -- Centralize options to keep the spec clean and easy to maintain.
    return
    {
        detection_methods = Project.detection_methods,
        patterns = Project.patterns,
    }
end

local function Setup(_, opts)
    local project_nvim = SafeRequire("project_nvim")
    if project_nvim == nil
    then
        return
    end

    -- Configure project root detection consistently across repositories.
    project_nvim.setup(opts or {})
end

return
{
    {
        "ahmedkhalf/project.nvim",
        event = Project.event,

        opts = function()
            return BuildOpts()
        end,

        config = function(_, opts)
            Setup(_, opts)
        end,
    },
}
