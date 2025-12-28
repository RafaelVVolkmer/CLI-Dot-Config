return {
  {
    "heilgar/bookmarks.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "kkharji/sqlite.lua",
    },
    cmd = { "Bookmarks", "BookmarksInfo" },
    opts = {
      default_mappings = false,
    },
    config = function(_, opts)
      require("bookmarks").setup(opts)

      pcall(function()
        require("telescope").load_extension("bookmarks")
      end)
    end,
  },
}
