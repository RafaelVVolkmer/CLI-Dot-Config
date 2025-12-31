-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Lazy =
{
    repo_url = "https://github.com/folke/lazy.nvim.git",
    branch = "stable",

    plugin_entrypoint = "lazy",

    data_dir = vim.fn.stdpath("data"),
    subdir = "lazy/lazy.nvim",

    spec_module = "plugins",
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

    -- Compatibility with older Neovim builds.
    return vim.loop.fs_stat(path) ~= nil
end

local function EnsureLazyInstalled()
    local lazypath = JoinPath(Lazy.data_dir, Lazy.subdir)

    if not PathExists(lazypath)
    then
        -- Bootstrap lazy.nvim if it is not installed yet.
        vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            Lazy.repo_url,
            "--branch=" .. Lazy.branch,
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

local function SetupLazy()
    local lazy = SafeRequire(Lazy.plugin_entrypoint)
    if lazy == nil
    then
        return
    end

    -- Load specs from the module directory (Lazy supports passing a module name).
    lazy.setup(Lazy.spec_module)
end

local function Setup()
    EnsureLazyInstalled()
    SetupLazy()
end

Setup()
