-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Keymaps =
{
    opts =
    {
        silent = true,
    },

    -- Use Lazy.nvim to load specific plugins on demand.
    lazy =
    {
        module = "lazy",
    },

    -- Plugin names as known by Lazy.nvim (keep these centralized).
    plugins =
    {
        harpoon = "harpoon",
        codex = "codex",
        bookmarks = "heilgar/bookmarks.nvim",
    },

    -- Common commands / entrypoints.
    commands =
    {
        neotree_toggle = "Neotree toggle",
        aerial_toggle = "AerialToggle right",
        lazygit = "LazyGit",

        diffview_open = "DiffviewOpen",
        diffview_close = "DiffviewClose",

        trouble_toggle = "TroubleToggle",
        toggleterm = "ToggleTerm",
        undotree = "UndotreeToggle",
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

local function LazyLoad(plugin_name)
    local lazy = SafeRequire(Keymaps.lazy.module)
    if lazy == nil
    then
        return
    end

    pcall(function()
        lazy.load({ plugins = { plugin_name } })
    end)
end

local function Map(mode, lhs, rhs, desc)
    local o =
    {
        silent = true,
        desc = desc,
    }

    vim.keymap.set(mode, lhs, rhs, o)
end

local function MapCmd(mode, lhs, cmd, desc)
    Map(mode, lhs, "<cmd>" .. cmd .. "<cr>", desc)
end

-- =========================================================
-- UI / NAVIGATION
-- =========================================================
local function SetupUiNavigation()
    Map("n", "<leader>e", function()
        vim.cmd(Keymaps.commands.neotree_toggle)
    end, "Explorer (Neo-tree)")

    Map("n", "<leader>o", function()
        vim.cmd(Keymaps.commands.aerial_toggle)
    end, "Outline (Aerial)")

    MapCmd("n", "<S-l>", "BufferLineCycleNext", "Next tab")
    MapCmd("n", "<S-h>", "BufferLineCyclePrev", "Prev tab")
end

-- =========================================================
-- SEARCH (TELESCOPE)
-- =========================================================
local function SetupSearch()
    MapCmd("n", "<leader>ff", "Telescope find_files", "Find files")
    MapCmd("n", "<leader>fg", "Telescope live_grep", "Live grep")
    MapCmd("n", "<leader>fb", "Telescope buffers", "Buffers")
    MapCmd("n", "<leader>fh", "Telescope help_tags", "Help")
    MapCmd("n", "<leader>fp", "Telescope projects", "Projects")
end

-- =========================================================
-- HARPOON (LAZY-LOADED)
-- =========================================================
local function SetupHarpoon()
    local function WithHarpoon(fn)
        return function()
            LazyLoad(Keymaps.plugins.harpoon)

            local harpoon = SafeRequire("harpoon")
            if harpoon == nil
            then
                return
            end

            fn(harpoon)
        end
    end

    Map("n", "<leader>ha", WithHarpoon(function(harpoon)
        harpoon:list():add()
    end), "Harpoon add file")

    Map("n", "<leader>hh", WithHarpoon(function(harpoon)
        local ui = harpoon.ui
        if ui == nil
        then
            return
        end

        ui:toggle_quick_menu(harpoon:list())
    end), "Harpoon menu")

    Map("n", "<leader>h1", WithHarpoon(function(harpoon)
        harpoon:list():select(1)
    end), "Harpoon 1")

    Map("n", "<leader>h2", WithHarpoon(function(harpoon)
        harpoon:list():select(2)
    end), "Harpoon 2")

    Map("n", "<leader>h3", WithHarpoon(function(harpoon)
        harpoon:list():select(3)
    end), "Harpoon 3")

    Map("n", "<leader>h4", WithHarpoon(function(harpoon)
        harpoon:list():select(4)
    end), "Harpoon 4")
end

-- =========================================================
-- GIT
-- =========================================================
local function SetupGit()
    Map("n", "<leader>gg", function()
        vim.cmd(Keymaps.commands.lazygit)
    end, "LazyGit")

    MapCmd("n", "<leader>gd", Keymaps.commands.diffview_open, "Diffview open")
    MapCmd("n", "<leader>gD", Keymaps.commands.diffview_close, "Diffview close")
end

-- =========================================================
-- DIAGNOSTICS / TROUBLE
-- =========================================================
local function SetupDiagnostics()
    MapCmd("n", "<leader>xx", Keymaps.commands.trouble_toggle, "Trouble")
    MapCmd("n", "<leader>xw", Keymaps.commands.trouble_toggle .. " workspace_diagnostics", "Workspace diagnostics")
    MapCmd("n", "<leader>xd", Keymaps.commands.trouble_toggle .. " document_diagnostics", "Document diagnostics")
end

-- =========================================================
-- TERMINAL
-- =========================================================
local function SetupTerminal()
    MapCmd("n", "<leader>tt", Keymaps.commands.toggleterm, "ToggleTerm")
end

-- =========================================================
-- AI (CODEX, LAZY-LOADED)
-- =========================================================
local function SetupAi()
    Map({ "n", "t" }, "<leader>ai", function()
        LazyLoad(Keymaps.plugins.codex)

        local codex = SafeRequire("codex")
        if codex == nil
        then
            return
        end

        codex.toggle()
    end, "Codex Toggle")
end

-- =========================================================
-- LSP (BUFFER-AGNOSTIC DEFAULTS)
-- =========================================================
local function SetupLsp()
    local o = Keymaps.opts

    -- These are safe global mappings; servers will no-op if not attached.
    vim.keymap.set("n", "K", vim.lsp.buf.hover, o)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, o)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, o)

    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,
    {
        desc = "Rename",
        silent = true,
    })

    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,
    {
        desc = "Code action",
        silent = true,
    })
end

-- =========================================================
-- UNDOTREE
-- =========================================================
local function SetupUndotree()
    MapCmd("n", "<leader>u", Keymaps.commands.undotree, "UndoTree")
end

-- =========================================================
-- BOOKMARKS (LAZY-LOADED + OPTIONAL TELESCOPE EXTENSION)
-- =========================================================
local function SetupBookmarks()
    local function WithBookmarks(fn)
        return function()
            LazyLoad(Keymaps.plugins.bookmarks)

            local bm = SafeRequire("bookmarks")
            if bm == nil
            then
                return
            end

            fn(bm)
        end
    end

    Map("n", "<leader>ba", WithBookmarks(function(bm)
        if bm.add_bookmark
        then
            bm.add_bookmark()
        end
    end), "Bookmark: add")

    Map("n", "<leader>br", WithBookmarks(function(bm)
        if bm.remove_bookmark
        then
            bm.remove_bookmark()
        end
    end), "Bookmark: remove")

    Map("n", "<leader>bn", WithBookmarks(function(bm)
        if bm.goto_next_bookmark
        then
            bm.goto_next_bookmark()
        end
    end), "Bookmark: next")

    Map("n", "<leader>bp", WithBookmarks(function(bm)
        if bm.goto_prev_bookmark
        then
            bm.goto_prev_bookmark()
        end
    end), "Bookmark: prev")

    Map("n", "<leader>bl", function()
        LazyLoad(Keymaps.plugins.bookmarks)

        -- Try Telescope first (better UX), fall back to :Bookmarks if unavailable.
        local telescope = SafeRequire("telescope")
        if telescope ~= nil
        then
            pcall(function()
                telescope.load_extension("bookmarks")
            end)

            if telescope.extensions and telescope.extensions.bookmarks
            then
                telescope.extensions.bookmarks.bookmarks()
                return
            end
        end

        vim.cmd("Bookmarks")
    end, "Bookmarks: list")
end

local function Setup()
    SetupUiNavigation()
    SetupSearch()
    SetupHarpoon()
    SetupGit()
    SetupDiagnostics()
    SetupTerminal()
    SetupAi()
    SetupLsp()
    SetupUndotree()
    SetupBookmarks()
end

Setup()
