 -- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
 -- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
 -- SPDX-License-Identifier: MIT
 
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- =========================
  -- THEME / UI BASICS
  -- =========================
  require("plugins.ui.theme"),
  require("plugins.ui.notify"),
  require("plugins.ui.noice"),
  require("plugins.ui.windline"),
  require("plugins.ui.bufferline"),
  require("plugins.ui.deadcolumn"),
  require("plugins.ui.colorizer"),
  require("plugins.ui.illuminate"),
  require("plugins.ui.toggleterm"),

  -- =========================
  -- NAVIGATION / EXPLORER / OUTLINE
  -- =========================
  require("plugins.ui.neotree"),
  require("plugins.ui.aerial"),
  require("plugins.tools.harpoon"),
  require("plugins.tools.project"),
  require("plugins.tools.persistence"),
  require("plugins.tools.bookmarks"),
  require("plugins.tools.undotree"),

  -- =========================
  -- SEARCH / MOTION
  -- =========================
  require("plugins.search.telescope"),
  require("plugins.search.telescope_fzf"),
  require("plugins.search.flash"),

  -- =========================
  -- GIT
  -- =========================
  require("plugins.git.gitsigns"),
  require("plugins.git.lazygit"),
  require("plugins.git.gitlinker"),
  require("plugins.git.diffview"),

  -- =========================
  -- LSP / COMPLETION
  -- =========================
  require("plugins.lsp.mason"),
  require("plugins.lsp.lspconfig"),
  require("plugins.lsp.cmp"),
  require("plugins.tools.treesitter"),

  -- =========================
  -- LINT / FORMAT / TAGS
  -- =========================
  require("plugins.lint.nvim_lint"),
  require("plugins.lint.conform"),
  require("plugins.lint.gutentags"),

  -- =========================
  -- EDITING
  -- =========================
  require("plugins.edit.autopairs"),
  require("plugins.edit.comment"),
  require("plugins.edit.trouble"),

  -- =========================
  -- KEYBINDING HELPERS
  -- =========================
  require("plugins.tools.whichkey"),

  -- =========================
  -- AI
  -- =========================
  require("plugins.ai.codex"),
})



