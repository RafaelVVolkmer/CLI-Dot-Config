-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local NvimLint =
{
    events =
    {
        "BufReadPost",
        "BufWritePost",
        "InsertLeave",
    },

    -- Filetype -> linters mapping
    linters_by_ft =
    {
        sh = { "shellcheck" },
        bash = { "shellcheck" },
    },

    autocmd_events =
    {
        "BufWritePost",
        "InsertLeave",
    },

    augroup_name = "UserNvimLint",
}

local function SafeRequire(module_name)
    local ok, mod = pcall(require, module_name)
    if ok
    then
        return mod
    end

    return nil
end

local function ConfigureLinters(lint)
    -- Centralize all linter configuration in one place.
    lint.linters_by_ft = NvimLint.linters_by_ft
end

local function CreateLintAutocmd(lint)
    local group = vim.api.nvim_create_augroup(NvimLint.augroup_name, { clear = true })

    vim.api.nvim_create_autocmd(NvimLint.autocmd_events,
    {
        group = group,

        callback = function()
            -- Never let lint errors interrupt editing (missing executable, config errors, etc.).
            pcall(lint.try_lint)
        end,
    })
end

local function SetupNvimLint()
    local lint = SafeRequire("lint")
    if lint == nil
    then
        return
    end

    ConfigureLinters(lint)
    CreateLintAutocmd(lint)
end

return
{
    {
        "mfussenegger/nvim-lint",
        event = NvimLint.events,

        config = function()
            SetupNvimLint()
        end,
    },
}
