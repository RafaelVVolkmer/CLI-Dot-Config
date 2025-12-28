 -- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
 -- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
 -- SPDX-License-Identifier: MIT

return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        show_close_icon = false,
        separator_style = "slant",
        offsets = {
          { filetype = "neo-tree", text = "Explorer", separator = true },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      vim.opt.showtabline = 2
    end,
  },
}
