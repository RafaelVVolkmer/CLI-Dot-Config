 -- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
 -- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
 -- SPDX-License-Identifier: MIT

return {
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    opts = {
      detection_methods = { "pattern", "lsp" },
      patterns = { ".git", "Makefile", "CMakeLists.txt", "compile_commands.json" },
    },
    config = function(_, opts)
      require("project_nvim").setup(opts)
    end,
  },
}
