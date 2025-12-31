-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Aerial =
{
    event = "VimEnter",

    dependencies =
    {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },

    backends =
    {
        "lsp",
        "treesitter",
    },

    layout =
    {
        width = 20,
        default_direction = "left",
        placement = "edge",
    },

    attach_mode = "global",
    open_automatic = true,

    keymaps =
    {
        close = "q",
        toggle = "<leader>o",
    },

    open_command = "AerialOpen! right",
    toggle_command = "AerialToggle! right",
    augroup_name = "UserAerial",
}

local function SafeRequire(module_name)
    local ok, mod = pcall(require, module_name)
    if ok
    then
        return mod
    end

    return nil
end

local function BuildOpts()
    return
    {
        backends = Aerial.backends,

        layout =
        {
            width = Aerial.layout.width,
            default_direction = Aerial.layout.default_direction,
            placement = Aerial.layout.placement,
        },

        attach_mode = Aerial.attach_mode,
        open_automatic = Aerial.open_automatic,

        keymaps =
        {
            -- Disable default "q" close mapping to avoid conflicts with your own habits/mappings.
            [Aerial.keymaps.close] = false,
        },
    }
end

local function OpenOnVimEnter()
    local group = vim.api.nvim_create_augroup(Aerial.augroup_name, { clear = true })

    vim.api.nvim_create_autocmd("VimEnter",
    {
        group = group,

        callback = function()
            -- Schedule to ensure UI is ready before opening the outline.
            vim.schedule(function()
                pcall(vim.cmd, Aerial.open_command)
            end)
        end,
    })
end

local function RegisterKeymaps()
    vim.keymap.set("n", Aerial.keymaps.toggle, "<cmd>" .. Aerial.toggle_command .. "<cr>",
    {
        silent = true,
    })
end

local function Setup()
    local aerial = SafeRequire("aerial")
    if aerial == nil
    then
        return
    end

    aerial.setup(BuildOpts())
    OpenOnVimEnter()
    RegisterKeymaps()
end

return
{
    {
        "stevearc/aerial.nvim",
        event = Aerial.event,
        dependencies = Aerial.dependencies,

        config = function()
            Setup()
        end,
    },
}
