-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Entry =
{
    core_module = "core",
    plugins_module = "plugins",
}

local function SafeRequire(module_name)
    local ok, mod = pcall(require, module_name)
    if ok
    then
        return mod
    end

    return nil
end

local function LoadCore()
    -- Load core settings first (options, keymaps, autocmds, globals, etc.).
    SafeRequire(Entry.core_module)
end

local function LoadPlugins()
    -- Load plugin bootstrap and specs after core is in place.
    SafeRequire(Entry.plugins_module)
end

local function Setup()
    LoadCore()
    LoadPlugins()
end

Setup()
