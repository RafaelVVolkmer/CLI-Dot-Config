 -- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
 -- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
 -- SPDX-License-Identifier: MIT

return {
  {
    "wtfox/jellybeans.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      italics = true,
      bold = true,
    },
    config = function(_, opts)
      pcall(function()
        require("jellybeans").setup(opts)
      end)

      vim.cmd.colorscheme("jellybeans")

      local function apply_transparency()
        local groups = {
          "Normal", "NormalNC", "EndOfBuffer", "SignColumn",
          "NormalFloat", "FloatBorder",
          "MsgArea", "WinSeparator", "VertSplit",

          "NeoTreeNormal", "NeoTreeNormalNC", "NeoTreeEndOfBuffer",
          "NeoTreeSignColumn", "NeoTreeFloatNormal", "NeoTreeFloatBorder",

          "AerialNormal", "AerialNormalNC",
          "AerialLine", "AerialGuide",
          "AerialFloatNormal", "AerialFloatBorder",

          "BufferLineFill", "BufferLineBackground",

          "Pmenu", "PmenuSel",
        }

        for _, g in ipairs(groups) do
          vim.api.nvim_set_hl(0, g, { bg = "NONE" })
        end
      end

      apply_transparency()

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.schedule(apply_transparency)
        end,
      })

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          vim.schedule(apply_transparency)
        end,
      })
    end,
  },
}
