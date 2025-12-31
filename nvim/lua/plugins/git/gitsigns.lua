-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Gitsigns =
{
    events =
    {
        "BufReadPre",
        "BufNewFile",
    },

    dependencies =
    {
        "nvim-lua/plenary.nvim",
    },

    opts =
    {
        current_line_blame = true,
    },

    keymaps =
    {
        next_hunk = { mode = "n", lhs = "]h" },
        prev_hunk = { mode = "n", lhs = "[h" },

        stage_hunk = { mode = { "n", "v" }, lhs = "<leader>hs" },
        reset_hunk = { mode = { "n", "v" }, lhs = "<leader>hr" },

        preview_hunk = { mode = "n", lhs = "<leader>hp" },
    },
}

local function SafeGetGitsignsModule()
    -- gitsigns is loaded by the plugin; in on_attach it's typically available in package.loaded.
    local mod = package.loaded.gitsigns
    if mod ~= nil
    then
        return mod
    end

    local ok, required = pcall(require, "gitsigns")
    if ok
    then
        return required
    end

    return nil
end

local function MapBuffer(bufnr, mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs,
    {
        buffer = bufnr,
        silent = true,
    })
end

local function ApplyKeymaps(bufnr, gs)
    -- Keep all mappings in one place for easier maintenance.
    MapBuffer(bufnr, Gitsigns.keymaps.next_hunk.mode, Gitsigns.keymaps.next_hunk.lhs, gs.next_hunk)
    MapBuffer(bufnr, Gitsigns.keymaps.prev_hunk.mode, Gitsigns.keymaps.prev_hunk.lhs, gs.prev_hunk)

    MapBuffer(bufnr, Gitsigns.keymaps.stage_hunk.mode, Gitsigns.keymaps.stage_hunk.lhs, gs.stage_hunk)
    MapBuffer(bufnr, Gitsigns.keymaps.reset_hunk.mode, Gitsigns.keymaps.reset_hunk.lhs, gs.reset_hunk)

    MapBuffer(bufnr, Gitsigns.keymaps.preview_hunk.mode, Gitsigns.keymaps.preview_hunk.lhs, gs.preview_hunk)
end

local function OnAttach(bufnr)
    local gs = SafeGetGitsignsModule()
    if gs == nil
    then
        return
    end

    -- Buffer-local mappings only apply when gitsigns is attached to the current buffer.
    ApplyKeymaps(bufnr, gs)
end

local function BuildOpts()
    return vim.tbl_deep_extend("force",
    {
        on_attach = OnAttach,
    }, Gitsigns.opts)
end

return
{
    {
        "lewis6991/gitsigns.nvim",
        event = Gitsigns.events,
        dependencies = Gitsigns.dependencies,

        opts = function()
            return BuildOpts()
        end,
    },
}
