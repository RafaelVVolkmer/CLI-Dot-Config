 -- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
 -- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
 -- SPDX-License-Identifier: MIT

return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- ícones
    },
    opts = {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = "❯ ",
        path_display = { "smart" },
        file_ignore_patterns = {
          "%.o$", "%.a$", "%.out$", "%.class$",
          "node_modules/", "%.git/", "dist/", "build/",
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
    end,
  },
}
