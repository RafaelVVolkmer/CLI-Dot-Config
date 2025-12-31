-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local LazyBootstrap =
{
    repo_url = "https://github.com/folke/lazy.nvim.git",
    branch = "stable",

    data_dir = vim.fn.stdpath("data"),
    subdir = "lazy/lazy.nvim",

    plugin_entrypoint = "lazy",

    -- Keep module lists centralized so the setup call stays clean.
    modules =
    {
        ui =
        {
            "plugins.ui.theme",
            "plugins.ui.notify",
            "plugins.ui.noice",
            "plugins.ui.windline",
            "plugins.ui.bufferline",
            "plugins.ui.deadcolumn",
            "plugins.ui.colorizer",
            "plugins.ui.illuminate",
            "plugins.ui.toggleterm",
        },

        navigation =
        {
            "plugins.ui.neotree",
            "plugins.ui.aerial",
            "plugins.tools.harpoon",
            "plugins.tools.project",
            "plugins.tools.persistence",
            "plugins.tools.bookmarks",
            "plugins.tools.undotree",
        },

        search =
        {
            "plugins.search.telescope",
            "plugins.search.telescope_fzf",
            "plugins.search.flash",
        },

        git =
        {
            "plugins.git.gitsigns",
            "plugins.git.lazygit",
            "plugins.git.gitlinker",
            "plugins.git.diffview",
        },

        lsp_completion =
        {
            "plugins.lsp.mason",
            "plugins.lsp.lspconfig",
            "plugins.lsp.cmp",
            "plugins.tools.treesitter",
        },

        lint_format_tags =
        {
            "plugins.lint.nvim_lint",
            "plugins.lint.conform",
            "plugins.lint.gutentags",
        },

        editing =
        {
            "plugins.edit.autopairs",
            "plugins.edit.comment",
            "plugins.edit.trouble",
        },

        key_helpers =
        {
            "plugins.tools.whichkey",
        },

        ai =
        {
            "plugins.ai.codex",
        },
    },
}

local function JoinPath(a, b)
    if vim.fs and vim.fs.joinpath
    then
        return vim.fs.joinpath(a, b)
    end

    return a .. "/" .. b
end

local function PathExists(path)
    if vim.uv
    then
        return vim.uv.fs_stat(path) ~= nil
    end

    -- Compatibility with older builds.
    return vim.loop.fs_stat(path) ~= nil
end

local function EnsureLazyOnRtp()
    local lazypath = JoinPath(LazyBootstrap.data_dir, LazyBootstrap.subdir)

    if not PathExists(lazypath)
    then
        -- Bootstrap lazy.nvim if it is not installed.
        vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            LazyBootstrap.repo_url,
            "--branch=" .. LazyBootstrap.branch,
            lazypath,
        })
    end

    vim.opt.rtp:prepend(lazypath)
end

local function SafeRequire(module_name)
    local ok, mod = pcall(require, module_name)
    if ok
    then
        return mod
    end

    return nil
end

local function RequirePluginSpec(module_name)
    -- Each module returns a Lazy spec table; load it safely to avoid hard startup failures.
    local ok, spec = pcall(require, module_name)
    if ok
    then
        return spec
    end

    return nil
end

local function CollectSpecs(modules_by_group)
    local specs = {}

    for _, group in pairs(modules_by_group)
    do
        for _, module_name in ipairs(group)
        do
            local spec = RequirePluginSpec(module_name)
            if spec ~= nil
            then
                table.insert(specs, spec)
            end
        end
    end

    return specs
end

local function SetupLazy()
    local lazy = SafeRequire(LazyBootstrap.plugin_entrypoint)
    if lazy == nil
    then
        return
    end

    -- Load all plugin specs from your organized module list.
    local specs = CollectSpecs(LazyBootstrap.modules)

    lazy.setup(specs)
end

local function Setup()
    -- This must run before requiring any plugin modules.
    EnsureLazyOnRtp()

    -- Configure plugins via Lazy.
    SetupLazy()
end

Setup()
