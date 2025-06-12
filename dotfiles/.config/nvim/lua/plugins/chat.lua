return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    {"nvim-lua/plenary.nvim", commit = "2d9b0617"},
    {"zbirenbaum/copilot.lua"},
  },
  build = "make tiktoken",
  opts = {},
}
