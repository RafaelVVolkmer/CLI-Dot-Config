-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local LspCompat =
{
    -- Neovim 0.11+ exposes vim.lsp.get_clients(); older plugins may still call buf_get_clients().
    new_api_field = "get_clients",
    legacy_field = "buf_get_clients",
}

local function HasNewApi()
    return (vim.lsp ~= nil) and (vim.lsp[LspCompat.new_api_field] ~= nil)
end

local function InstallLegacyAlias()
    -- Provide a backward-compatible alias for plugins that still rely on buf_get_clients().
    vim.lsp[LspCompat.legacy_field] = function(bufnr)
        return vim.lsp.get_clients({ bufnr = bufnr or 0 })
    end
end

local function Setup()
    if HasNewApi()
    then
        InstallLegacyAlias()
    end
end

Setup()
