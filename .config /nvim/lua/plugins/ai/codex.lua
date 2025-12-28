 -- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
 -- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
 -- SPDX-License-Identifier: MIT

return {
  {
    "johnseth97/codex.nvim",
    name = "codex",
    cmd = { "Codex", "CodexToggle" },
    opts = {
      panel = false,

      border = "rounded",
      width  = 0.85,
      height = 0.85,
      autoinstall = true,

      keymaps = {
        toggle = nil,
        quit   = "<C-q>",
      },
    },
  },
}
