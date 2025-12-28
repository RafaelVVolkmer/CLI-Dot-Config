 -- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
 -- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
 -- SPDX-License-Identifier: MIT

return {
  {
    "catgoose/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.opt.termguicolors = true

      require("colorizer").setup({
        "*",
      }, {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        tailwind = true,
        mode = "background",
      })
    end,
  },
}
