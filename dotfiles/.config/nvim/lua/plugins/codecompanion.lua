return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- {"nvim-lua/plenary.nvim", commit = "2d9b0617"},
  },
  opts = {
    strategies = {
      chat = {
        adapter = "copilot",
        model = "claude-sonnet-4"
      },
      inLine = {
        adapter = "copilot",
        model = "claude-sonnet-4"
      },
    }
  },
}
