-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local AutoQuit =
{
    events =
    {
        "BufEnter",
        "WinEnter",
    },

    augroup_name = "UserAutoQuit",

    -- Windows with these filetypes are considered "UI-only" and should not keep Neovim open.
    ignored_filetypes =
    {
        ["neo-tree"] = true,
        ["aerial"] = true,
    },
}

local function IsRealWindow(win_id)
    local cfg = vim.api.nvim_win_get_config(win_id)
    return cfg.relative == ""
end

local function GetWindowFiletype(win_id)
    local buf = vim.api.nvim_win_get_buf(win_id)
    return vim.bo[buf].filetype
end

local function IsIgnoredFiletype(filetype)
    return AutoQuit.ignored_filetypes[filetype] == true
end

local function CountRealNonIgnoredWindows()
    local wins = vim.api.nvim_list_wins()
    local count = 0

    for _, win_id in ipairs(wins)
    do
        if IsRealWindow(win_id)
        then
            local ft = GetWindowFiletype(win_id)
            if not IsIgnoredFiletype(ft)
            then
                count = count + 1
            end
        end
    end

    return count
end

local function ShouldQuitAll()
    -- Quit only when there are no "real" editing windows left.
    return CountRealNonIgnoredWindows() == 0
end

local function QuitAllIfNeeded()
    -- Schedule the check to run after the current event settles.
    vim.schedule(function()
        if ShouldQuitAll()
        then
            vim.cmd("qa")
        end
    end)
end

local function Setup()
    local group = vim.api.nvim_create_augroup(AutoQuit.augroup_name, { clear = true })

    vim.api.nvim_create_autocmd(AutoQuit.events,
    {
        group = group,
        callback = QuitAllIfNeeded,
    })
end

Setup()
