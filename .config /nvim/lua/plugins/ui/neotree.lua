 -- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
 -- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
 -- SPDX-License-Identifier: MIT

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = false, 
        popup_border_style = "rounded",

        default_component_configs = {
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰜌",
            default = "",
          },
          git_status = {
            symbols = {
              added     = "✚",
              modified  = "",
              deleted   = "✖",
              renamed   = "",
              untracked = "",
              ignored   = "",
              unstaged  = "󰄱",
              staged    = "",
              conflict  = "",
            },
          },
        },

        window = {
          position = "left",
          width = 20,
          mappings = {
            ["<space>"] = "toggle_node",
            ["<cr>"] = "open",
            ["o"] = "open",
            ["h"] = "close_node",
            ["l"] = "open",
            ["q"] = "close_window",
          },
        },

        filesystem = {
          follow_current_file = { enabled = true },
          hijack_netrw_behavior = "open_default",
          use_libuv_file_watcher = true,
        },

        git_status = {
          window = { position = "float" },
        },
      })

      local function open_tree()
        pcall(function()
          require("neo-tree.command").execute({
            action = "show",
            source = "filesystem",
            position = "left",
            reveal = true,
            width = 20,
          })
        end)
      end

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          open_tree()
        end,
      })

      vim.api.nvim_create_autocmd("BufWinLeave", {
        callback = function(args)
          if vim.bo[args.buf].filetype == "neo-tree" and vim.v.exiting == 0 then
            vim.schedule(open_tree)
          end
        end,
      })
    end,
  },
}
