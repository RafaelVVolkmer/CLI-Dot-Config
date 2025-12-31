-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Core =
{
    modules =
    {
        "core.options",
        "core.keymaps",
        "core.compat",
        "core.autocmds",
    },
}

local function SafeRequire(module_name)
    local ok = pcall(require, module_name)
    return ok
end

local function LoadModules()
    -- Load order matters: options/leaders first, then keymaps, then compatibility and autocmds.
    for _, module_name in ipairs(Core.modules)
    do
        SafeRequire(module_name)
    end
end

local function Setup()
    LoadModules()
end

Setup()
