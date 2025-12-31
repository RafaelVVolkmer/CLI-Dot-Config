-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Gutentags =
{
    cache_subdir = "gutentags",

    events =
    {
        "BufReadPre",
        "BufNewFile",
    },

    excluded_filetypes =
    {
        "neo-tree",
        "neo-tree-popup",
        "aerial",
        "TelescopePrompt",
        "toggleterm",
        "terminal",
        "lazy",
        "mason",
        "help",
    },

    project_root_markers =
    {
        "go.work",
        "go.mod",
        ".git",
        "compile_commands.json",
        "CMakeLists.txt",
        "Makefile",
    },
}

local function JoinPath(a, b)
    if vim.fs and vim.fs.joinpath
    then
        return vim.fs.joinpath(a, b)
    end

    return a .. "/" .. b
end

local function EnsureDir(path)
    if vim.fn.isdirectory(path) == 0
    then
        -- Create the cache directory lazily and safely (including parents).
        vim.fn.mkdir(path, "p")
    end
end

local function AppendUnique(opt, value)
    local current = opt:get()

    for _, item in ipairs(current)
    do
        if item == value
        then
            return
        end
    end

    opt:append(value)
end

local function SetupGutentags()
    local cache_dir = JoinPath(vim.fn.stdpath("cache"), Gutentags.cache_subdir)

    -- Keep tags in Neovim's cache directory to avoid polluting repositories.
    vim.g.gutentags_cache_dir = cache_dir
    EnsureDir(cache_dir)

    -- Generate tags automatically in the most common workflows.
    vim.g.gutentags_generate_on_write = 1
    vim.g.gutentags_generate_on_missing = 1
    vim.g.gutentags_generate_on_new = 1

    -- Avoid generating tags for UI buffers / special filetypes.
    vim.g.gutentags_exclude_filetypes = Gutentags.excluded_filetypes

    -- Define project roots so Gutentags knows where to start.
    vim.g.gutentags_project_root = Gutentags.project_root_markers

    -- Make Neovim discover tags generated under the cache directory.
    AppendUnique(vim.opt.tags, cache_dir .. "/**/tags")
end

return
{
    {
        "ludovicchabant/vim-gutentags",
        event = Gutentags.events,

        init = function()
            SetupGutentags()
        end,
    },
}
