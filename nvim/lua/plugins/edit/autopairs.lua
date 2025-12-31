-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local AutoPairs =
{
    event = "InsertEnter",

    disable_filetypes =
    {
        "TelescopePrompt",
    },

    setup_opts =
    {
        check_ts = true,

        fast_wrap =
        {
            map = "<M-e>",
            chars = { "{", "[", "(", "\"", "'", "`" },
            pattern = [=[[%'%"%>%]%)%}%,]]=],
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "Search",
            highlight_grey = "Comment",
        },
    },

    cmp_integration =
    {
        module_name = "cmp",
        handler_module = "nvim-autopairs.completion.cmp",
        event_name = "confirm_done",
    },
}

local function SafeRequire(module_name)
    local ok, mod = pcall(require, module_name)
    if ok
    then
        return mod
    end

    return nil
end

local function ConfigureAutoPairs()
    local npairs = SafeRequire("nvim-autopairs")
    if npairs == nil
    then
        return
    end

    -- Core autopairs behavior.
    npairs.setup(vim.tbl_deep_extend("force",
    {
        disable_filetype = AutoPairs.disable_filetypes,
    }, AutoPairs.setup_opts))
end

local function ConfigureCmpIntegration()
    -- Optional integration: only enable if nvim-cmp is installed.
    local cmp = SafeRequire(AutoPairs.cmp_integration.module_name)
    if cmp == nil
    then
        return
    end

    local cmp_autopairs = SafeRequire(AutoPairs.cmp_integration.handler_module)
    if cmp_autopairs == nil
    then
        return
    end

    -- Ensure pairs are inserted correctly when completion items are confirmed.
    cmp.event:on(AutoPairs.cmp_integration.event_name, cmp_autopairs.on_confirm_done())
end

local function Setup()
    ConfigureAutoPairs()
    ConfigureCmpIntegration()
end

return
{
    {
        "windwp/nvim-autopairs",
        event = AutoPairs.event,

        config = function()
            Setup()
        end,
    },
}
