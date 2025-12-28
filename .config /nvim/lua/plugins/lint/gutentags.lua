 -- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
 -- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
 -- SPDX-License-Identifier: MIT

return {
  {
    "ludovicchabant/vim-gutentags",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.g.gutentags_cache_dir = vim.fn.stdpath("cache") .. "/gutentags"
      vim.g.gutentags_generate_on_write = 1
      vim.g.gutentags_generate_on_missing = 1
      vim.g.gutentags_generate_on_new = 1

      vim.g.gutentags_project_root = {
        ".git",
        "compile_commands.json",
        "Makefile",
        "CMakeLists.txt",
      }

      vim.opt.tags:append(vim.g.gutentags_cache_dir .. "/**/tags")
    end,
  },
}
