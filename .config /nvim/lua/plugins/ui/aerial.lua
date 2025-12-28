 -- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
 -- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
 -- SPDX-License-Identifier: MIT

return {
  {
    "stevearc/aerial.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("aerial").setup({
        backends = { "lsp", "treesitter" },

        layout = {
          width = 20,
          default_direction = "right",
          placement = "window",
        },

        attach_mode = "global",
        open_automatic = true,

        keymaps = {
          ["q"] = false,
        },
      })

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          vim.schedule(function()
            pcall(vim.cmd, "AerialOpen! right")
          end)
        end,
      })

      vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle! right<cr>", { silent = true })
    end,
  },
}
