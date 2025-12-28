 -- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
 -- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
 -- SPDX-License-Identifier: MIT

return {
  {
    "windwp/windline.nvim",
    event = "VimEnter",
    dependencies = { "lewis6991/gitsigns.nvim" },
    config = function()
      
      vim.g.terminal_color_4  = "#ff9aa2"
      vim.g.terminal_color_12 = "#ffb3ba" 


      vim.g.terminal_color_6  = "#ffd1dc"
      vim.g.terminal_color_14 = "#ffe5ea"


      require("wlsample.wind")
    end,
  },
}
