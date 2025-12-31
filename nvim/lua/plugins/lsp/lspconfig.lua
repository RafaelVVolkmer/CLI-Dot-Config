-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Lsp =
{
    lazy = false,

    servers =
    {
        clangd =
        {
            -- C/C++ / Objective-C
            cmd = { "clangd", "--background-index", "--clang-tidy" },
            filetypes = { "c", "cpp", "objc", "objcpp" },
            root_markers = { ".clangd", "compile_commands.json", ".git" },
            single_file_support = true,
        },

        bashls =
        {
            -- Shell
            cmd = { "bash-language-server", "start" },
            filetypes = { "sh", "bash" },
            root_markers = { ".git" },
            single_file_support = true,
        },

        lua_ls =
        {
            -- Lua (Neovim runtime)
            cmd = { "lua-language-server" },
            filetypes = { "lua" },
            root_markers =
            {
                ".luarc.json",
                ".luarc.jsonc",
                ".stylua.toml",
                "stylua.toml",
                ".git",
            },
            single_file_support = true,

            settings =
            {
                Lua =
                {
                    runtime = { version = "LuaJIT" },

                    -- Tell the server that `vim` is a known global.
                    diagnostics = { globals = { "vim" } },

                    workspace =
                    {
                        -- Make the server aware of Neovim's runtime files (API, stdlib, etc.).
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },

                    telemetry = { enable = false },
                },
            },
        },

        gopls =
        {
            -- Go
            cmd = nil, -- resolved at runtime
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            root_markers = { "go.work", "go.mod", ".git" },
            single_file_support = true,

            settings =
            {
                gopls =
                {
                    analyses =
                    {
                        unusedparams = true,
                        nilness = true,
                        unusedwrite = true,
                        useany = true,
                    },

                    staticcheck = true,
                    gofumpt = true,
                },
            },
        },
    },

    enable =
    {
        "clangd",
        "bashls",
        "lua_ls",
        "gopls",
    },
}

local function IsExecutable(path)
    return vim.fn.executable(path) == 1
end

local function ResolveGoplsCmd()
    -- Prefer PATH, but allow a pinned toolchain under ~/go/bin.
    if IsExecutable("gopls")
    then
        return { "gopls" }
    end

    local fallback = vim.fn.expand("~/go/bin/gopls")
    if IsExecutable(fallback)
    then
        return { fallback }
    end

    -- If gopls is not available, keep nil to avoid hard errors during startup.
    return nil
end

local function ConfigureServer(name, cfg)
    if (cfg == nil) or (type(cfg) ~= "table")
    then
        return
    end

    vim.lsp.config(name, cfg)
end

local function ConfigureServers()
    local servers = Lsp.servers

    -- Resolve dynamic commands and apply per-server configuration.
    servers.gopls.cmd = ResolveGoplsCmd()

    for name, cfg in pairs(servers)
    do
        -- Skip servers that have an unresolved command (e.g., gopls missing).
        if (cfg.cmd == nil) or (type(cfg.cmd) ~= "table") or (#cfg.cmd == 0)
        then
            if name ~= "gopls"
            then
                ConfigureServer(name, cfg)
            end
        else
            ConfigureServer(name, cfg)
        end
    end
end

local function EnableServers()
    -- Enable only the servers we actually configured and that have a valid command.
    local enabled = {}

    for _, name in ipairs(Lsp.enable)
    do
        local cfg = Lsp.servers[name]
        if (cfg ~= nil) and (cfg.cmd ~= nil) and (type(cfg.cmd) == "table") and (#cfg.cmd > 0)
        then
            table.insert(enabled, name)
        end
    end

    vim.lsp.enable(enabled)
end

local function Setup()
    ConfigureServers()
    EnableServers()
end

return
{
    {
        "neovim/nvim-lspconfig",
        lazy = Lsp.lazy,

        config = function()
            Setup()
        end,
    },
}
