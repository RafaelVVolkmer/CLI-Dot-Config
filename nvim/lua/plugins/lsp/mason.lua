-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Mason =
{
    mason =
    {
        repo = "williamboman/mason.nvim",

        -- Using `config = true` is fine, but we keep it explicit so this file can grow.
        config = function()
            require("mason").setup({})
        end,
    },

    lspconfig =
    {
        repo = "mason-org/mason-lspconfig.nvim",

        -- No opts for now; keep a config function so it is easy to extend later
        -- (e.g., ensure_installed, automatic installation, handlers).
        config = function()
            local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
            if ok
            then
                mason_lspconfig.setup({})
            end
        end,
    },
}

local function BuildSpecs()
    return
    {
        {
            Mason.mason.repo,
            config = Mason.mason.config,
        },

        {
            Mason.lspconfig.repo,

            -- Ensure mason is available before configuring the bridge plugin.
            dependencies =
            {
                Mason.mason.repo,
            },

            config = Mason.lspconfig.config,
        },
    }
end

return BuildSpecs()
