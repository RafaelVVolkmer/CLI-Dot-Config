 -- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
 -- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
 -- SPDX-License-Identifier: MIT

local map = vim.keymap.set
local opts = { silent = true }

local function lazy_load(name)
  pcall(function()
    require("lazy").load({ plugins = { name } })
  end)
end

map("n", "<leader>e", function()
  vim.cmd("Neotree toggle")
end, { desc = "Explorer (Neo-tree)", silent = true })

map("n", "<leader>o", function()
  vim.cmd("AerialToggle right")
end, { desc = "Outline (Aerial)", silent = true })

map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next tab", silent = true })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev tab", silent = true })

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files", silent = true })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>",  { desc = "Live grep", silent = true })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>",    { desc = "Buffers", silent = true })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>",  { desc = "Help", silent = true })
map("n", "<leader>fp", "<cmd>Telescope projects<cr>",   { desc = "Projects", silent = true })

map("n", "<leader>ha", function()
  lazy_load("harpoon")
  require("harpoon"):list():add()
end, { desc = "Harpoon add file", silent = true })

map("n", "<leader>hh", function()
  lazy_load("harpoon")
  require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
end, { desc = "Harpoon menu", silent = true })

map("n", "<leader>h1", function()
  lazy_load("harpoon"); require("harpoon"):list():select(1)
end, { desc = "Harpoon 1", silent = true })

map("n", "<leader>h2", function()
  lazy_load("harpoon"); require("harpoon"):list():select(2)
end, { desc = "Harpoon 2", silent = true })

map("n", "<leader>h3", function()
  lazy_load("harpoon"); require("harpoon"):list():select(3)
end, { desc = "Harpoon 3", silent = true })

map("n", "<leader>h4", function()
  lazy_load("harpoon"); require("harpoon"):list():select(4)
end, { desc = "Harpoon 4", silent = true })

map("n", "<leader>gg", function()
  vim.cmd("LazyGit")
end, { desc = "LazyGit", silent = true })

map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diffview open", silent = true })
map("n", "<leader>gD", "<cmd>DiffviewClose<cr>", { desc = "Diffview close", silent = true })

map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Trouble", silent = true })
map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace diagnostics", silent = true })
map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",  { desc = "Document diagnostics", silent = true })

map("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "ToggleTerm", silent = true })

map({ "n", "t" }, "<leader>ai", function()
  lazy_load("codex")
  require("codex").toggle()
end, { desc = "Codex Toggle", silent = true })

map("n", "K", vim.lsp.buf.hover, opts)
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "gr", vim.lsp.buf.references, opts)
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename", silent = true })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action", silent = true })

vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { silent = true, desc = "UndoTree" })

vim.keymap.set("n", "<leader>ba", function()
  pcall(function() require("lazy").load({ plugins = { "heilgar/bookmarks.nvim" } }) end)
  local ok, bm = pcall(require, "bookmarks")
  if ok and bm.add_bookmark then bm.add_bookmark() end
end, { silent = true, desc = "Bookmark: add" })

vim.keymap.set("n", "<leader>br", function()
  pcall(function() require("lazy").load({ plugins = { "heilgar/bookmarks.nvim" } }) end)
  local ok, bm = pcall(require, "bookmarks")
  if ok and bm.remove_bookmark then bm.remove_bookmark() end
end, { silent = true, desc = "Bookmark: remove" })

vim.keymap.set("n", "<leader>bn", function()
  pcall(function() require("lazy").load({ plugins = { "heilgar/bookmarks.nvim" } }) end)
  local ok, bm = pcall(require, "bookmarks")
  if ok and bm.goto_next_bookmark then bm.goto_next_bookmark() end
end, { silent = true, desc = "Bookmark: next" })

vim.keymap.set("n", "<leader>bp", function()
  pcall(function() require("lazy").load({ plugins = { "heilgar/bookmarks.nvim" } }) end)
  local ok, bm = pcall(require, "bookmarks")
  if ok and bm.goto_prev_bookmark then bm.goto_prev_bookmark() end
end, { silent = true, desc = "Bookmark: prev" })

vim.keymap.set("n", "<leader>bl", function()
  pcall(function() require("lazy").load({ plugins = { "heilgar/bookmarks.nvim" } }) end)
  pcall(function() require("telescope").load_extension("bookmarks") end)
  local ok, tel = pcall(require, "telescope")
  if ok and tel.extensions and tel.extensions.bookmarks then
    tel.extensions.bookmarks.bookmarks()
  else
    vim.cmd("Bookmarks")
  end
end, { silent = true, desc = "Bookmarks: list" })

