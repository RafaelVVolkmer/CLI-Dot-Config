 -- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
 -- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
 -- SPDX-License-Identifier: MIT

local function should_quit_all()
  local wins = vim.api.nvim_list_wins()
  local real = 0

  for _, win in ipairs(wins) do
    local cfg = vim.api.nvim_win_get_config(win)
    if cfg.relative == "" then
      local buf = vim.api.nvim_win_get_buf(win)
      local ft = vim.bo[buf].filetype
      if ft ~= "neo-tree" and ft ~= "aerial" then
        real = real + 1
      end
    end
  end

  return real == 0
end

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  callback = function()
    vim.schedule(function()
      if should_quit_all() then
        vim.cmd("qa")
      end
    end)
  end,
})
