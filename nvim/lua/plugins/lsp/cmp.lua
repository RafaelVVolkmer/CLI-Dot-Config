-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Cmp =
{
    event = "InsertEnter",

    dependencies =
    {
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },

    keys =
    {
        complete = "<C-Space>",
        confirm = "<CR>",
        next = "<Tab>",
        prev = "<S-Tab>",
    },

    sources =
    {
        { name = "nvim_lsp" },
        { name = "luasnip" },
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

local function ExpandSnippet(luasnip, args)
    luasnip.lsp_expand(args.body)
end

local function SelectNextOrSnippetOrFallback(cmp, luasnip, fallback)
    if cmp.visible()
    then
        cmp.select_next_item()
        return
    end

    if luasnip.expand_or_jumpable()
    then
        luasnip.expand_or_jump()
        return
    end

    fallback()
end

local function SelectPrevOrSnippetOrFallback(cmp, luasnip, fallback)
    if cmp.visible()
    then
        cmp.select_prev_item()
        return
    end

    if luasnip.jumpable(-1)
    then
        luasnip.jump(-1)
        return
    end

    fallback()
end

local function BuildMapping(cmp, luasnip)
    return cmp.mapping.preset.insert(
    {
        [Cmp.keys.complete] = cmp.mapping.complete(),
        [Cmp.keys.confirm] = cmp.mapping.confirm({ select = true }),

        [Cmp.keys.next] = cmp.mapping(function(fallback)
            SelectNextOrSnippetOrFallback(cmp, luasnip, fallback)
        end, { "i", "s" }),

        [Cmp.keys.prev] = cmp.mapping(function(fallback)
            SelectPrevOrSnippetOrFallback(cmp, luasnip, fallback)
        end, { "i", "s" }),
    })
end

local function BuildSetup(cmp, luasnip)
    -- Keep config construction isolated: easier to read and safer to extend.
    return
    {
        snippet =
        {
            expand = function(args)
                ExpandSnippet(luasnip, args)
            end,
        },

        mapping = BuildMapping(cmp, luasnip),
        sources = Cmp.sources,
    }
end

local function SetupCmp()
    local cmp = SafeRequire("cmp")
    local luasnip = SafeRequire("luasnip")

    if (cmp == nil) or (luasnip == nil)
    then
        return
    end

    -- nvim-cmp is configured only when both completion and snippet engines are available.
    cmp.setup(BuildSetup(cmp, luasnip))
end

return
{
    {
        "hrsh7th/nvim-cmp",
        event = Cmp.event,
        dependencies = Cmp.dependencies,

        config = function()
            SetupCmp()
        end,
    },
}
