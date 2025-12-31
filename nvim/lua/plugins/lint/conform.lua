-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Conform =
{
    events =
    {
        "BufWritePre",
    },

    format_on_save =
    {
        timeout_ms = 1500,
        lsp_fallback = true,
    },

    -- Filetype -> formatter(s) mapping
    formatters_by_ft =
    {
        c = { "clang_format" },
        cpp = { "clang_format" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        lua = { "stylua" },
    },
}

local function BuildOpts()
    -- Keep opts construction centralized so it stays easy to extend.
    return
    {
        format_on_save = Conform.format_on_save,
        formatters_by_ft = Conform.formatters_by_ft,
    }
end

return
{
    {
        "stevearc/conform.nvim",
        event = Conform.events,

        opts = function()
            -- Use a function so the table is rebuilt safely and can evolve
            -- (e.g., conditionals by OS or project) without side effects.
            return BuildOpts()
        end,
    },
}
