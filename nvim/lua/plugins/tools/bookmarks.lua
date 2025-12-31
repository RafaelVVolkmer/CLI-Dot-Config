-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Bookmarks =
{
    commands =
    {
        "Bookmarks",
        "BookmarksInfo",
    },

    dependencies =
    {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "kkharji/sqlite.lua",
    },

    opts =
    {
        default_mappings = false,
    },

    telescope_extension = "bookmarks",
}

local function SafeRequire(module_name)
    local ok, mod = pcall(require, module_name)
    if ok
    then
        return mod
    end

    return nil
end

local function SetupBookmarks(opts)
    local bookmarks = SafeRequire("bookmarks")
    if bookmarks == nil
    then
        return
    end

    -- Configure bookmarks with explicit options for predictable behavior.
    bookmarks.setup(opts or {})
end

local function LoadTelescopeExtension()
    -- Optional integration: load the Telescope extension only if Telescope is available.
    local telescope = SafeRequire("telescope")
    if telescope == nil
    then
        return
    end

    pcall(function()
        telescope.load_extension(Bookmarks.telescope_extension)
    end)
end

local function BuildOpts()
    return Bookmarks.opts
end

local function Setup(_, opts)
    SetupBookmarks(opts)
    LoadTelescopeExtension()
end

return
{
    {
        "heilgar/bookmarks.nvim",
        dependencies = Bookmarks.dependencies,
        cmd = Bookmarks.commands,

        opts = function()
            return BuildOpts()
        end,

        config = function(_, opts)
            Setup(_, opts)
        end,
    },
}
