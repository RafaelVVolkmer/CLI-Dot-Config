 -- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
 -- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
 -- SPDX-License-Identifier: MIT

return {
  {
    "Bekaboo/deadcolumn.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      scope = "line",
      modes = { "n", "i", "R" },
      blending = {
        threshold = 0.4,
        colorcode = "#2A1A1E",
        hlgroup = { "NonText", "bg" },
      },
      warning = {
        alpha = 0.4,
        offset = 0,
        colorcode = "#C76B73",
        hlgroup = { "Error", "bg" },
      },
    },
    config = function(_, opts)
      require("deadcolumn").setup(opts)
    end,
  },
}
