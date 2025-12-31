-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Options =
{
    leaders =
    {
        leader = " ",
        localleader = " ",
    },

    ui =
    {
        termguicolors = true,

        number = true,
        relativenumber = false,
        signcolumn = "yes",
        cursorline = true,

        -- Hide tildes (~) on empty lines at EOF.
        fillchars =
        {
            eob = " ",
        },

        -- 0 disables the column; a string like "80" enables it.
        colorcolumn = "80",

        -- Popup / floating transparency.
        pumblend = 10,
        winblend = 10,
    },

    windows =
    {
        splitright = true,
        splitbelow = true,
    },

    search =
    {
        ignorecase = true,
        smartcase = true,
    },

    timing =
    {
        updatetime = 250,
        timeoutlen = 400,
    },
}

local function SetLeaders()
    -- Leaders must be set before loading mappings.
    vim.g.mapleader = Options.leaders.leader
    vim.g.maplocalleader = Options.leaders.localleader
end

local function ApplyUiOptions()
    vim.opt.termguicolors = Options.ui.termguicolors

    vim.opt.number = Options.ui.number
    vim.opt.relativenumber = Options.ui.relativenumber
    vim.opt.signcolumn = Options.ui.signcolumn
    vim.opt.cursorline = Options.ui.cursorline

    vim.opt.fillchars:append(Options.ui.fillchars)

    vim.opt.colorcolumn = Options.ui.colorcolumn

    vim.opt.pumblend = Options.ui.pumblend
    vim.opt.winblend = Options.ui.winblend
end

local function ApplyWindowOptions()
    vim.opt.splitright = Options.windows.splitright
    vim.opt.splitbelow = Options.windows.splitbelow
end

local function ApplySearchOptions()
    vim.opt.ignorecase = Options.search.ignorecase
    vim.opt.smartcase = Options.search.smartcase
end

local function ApplyTimingOptions()
    vim.opt.updatetime = Options.timing.updatetime
    vim.opt.timeoutlen = Options.timing.timeoutlen
end

local function Setup()
    -- =========================================================
    -- LEADERS
    -- =========================================================
    SetLeaders()

    -- =========================================================
    -- UI
    -- =========================================================
    ApplyUiOptions()

    -- =========================================================
    -- WINDOWS
    -- =========================================================
    ApplyWindowOptions()

    -- =========================================================
    -- SEARCH
    -- =========================================================
    ApplySearchOptions()

    -- =========================================================
    -- TIMING
    -- =========================================================
    ApplyTimingOptions()
end

Setup()
