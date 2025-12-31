-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local NeoTree =
{
    lazy = false,
    branch = "v3.x",

    dependencies =
    {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },

    ui =
    {
        popup_border_style = "rounded",
        close_if_last_window = false,

        window =
        {
            position = "left",
            width = 20,

            mappings =
            {
                ["<space>"] = "toggle_node",
                ["<cr>"] = "open",
                ["o"] = "open",
                ["h"] = "close_node",
                ["l"] = "open",
                ["q"] = "close_window",
            },
        },
    },

    icons =
    {
        folder_closed = "",
        folder_open = "",
        folder_empty = "󰜌",
        default = "",
    },

    git_symbols =
    {
        added = "✚",
        modified = "",
        deleted = "✖",
        renamed = "",
        untracked = "",
        ignored = "",
        unstaged = "󰄱",
        staged = "",
        conflict = "",
    },

    filesystem =
    {
        follow_current_file = true,
        hijack_netrw_behavior = "open_default",
        use_libuv_file_watcher = true,
    },

    git_status =
    {
        window_position = "float",
    },

    open_action =
    {
        action = "show",
        source = "filesystem",
        position = "left",
        reveal = true,
        width = 20,
    },

    augroup_name = "UserNeoTree",
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
        close_if_last_window = NeoTree.ui.close_if_last_window,
        popup_border_style = NeoTree.ui.popup_border_style,

        default_component_configs =
        {
            icon =
            {
                folder_closed = NeoTree.icons.folder_closed,
                folder_open = NeoTree.icons.folder_open,
                folder_empty = NeoTree.icons.folder_empty,
                default = NeoTree.icons.default,
            },

            git_status =
            {
                symbols = NeoTree.git_symbols,
            },
        },

        window =
        {
            position = NeoTree.ui.window.position,
            width = NeoTree.ui.window.width,
            mappings = NeoTree.ui.window.mappings,
        },

        filesystem =
        {
            follow_current_file = { enabled = NeoTree.filesystem.follow_current_file },
            hijack_netrw_behavior = NeoTree.filesystem.hijack_netrw_behavior,
            use_libuv_file_watcher = NeoTree.filesystem.use_libuv_file_watcher,
        },

        git_status =
        {
            window = { position = NeoTree.git_status.window_position },
        },
    }
end

local function OpenFilesystemTree()
    local command = SafeRequire("neo-tree.command")
    if command == nil
    then
        return
    end

    -- Keep the file explorer visible as part of the UI layout.
    pcall(function()
        command.execute(NeoTree.open_action)
    end)
end

local function CreateAutocmds()
    local group = vim.api.nvim_create_augroup(NeoTree.augroup_name, { clear = true })

    vim.api.nvim_create_autocmd("VimEnter",
    {
        group = group,

        callback = function()
            OpenFilesystemTree()
        end,
    })

    vim.api.nvim_create_autocmd("BufWinLeave",
    {
        group = group,

        callback = function(args)
            -- If the Neo-tree window is closed while Neovim is still running, reopen it.
            if (vim.bo[args.buf].filetype == "neo-tree") and (vim.v.exiting == 0)
            then
                vim.schedule(OpenFilesystemTree)
            end
        end,
    })
end

local function Setup()
    local neotree = SafeRequire("neo-tree")
    if neotree == nil
    then
        return
    end

    neotree.setup(BuildOpts())
    CreateAutocmds()
end

return
{
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = NeoTree.branch,
        lazy = NeoTree.lazy,
        dependencies = NeoTree.dependencies,

        config = function()
            Setup()
        end,
    },
}
