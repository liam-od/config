return {
  'zbirenbaum/copilot.lua',
  event = "InsertEnter",
  config = function()
    local suggestion = require("copilot.suggestion")

    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-l>",
          next = "<C-j>",
          prev = "<C-k>",
        },
      },
      panel = { enabled = false},
      filetypes = {
        python = true,
        lua = true,
        markdown = true,
      },
    })

    vim.keymap.set("n", "<C-;>", suggestion.toggle_auto_trigger, { desc = "Toggle Copilot Auto Trigger" })
    vim.keymap.set("i", "<C-;>", suggestion.dismiss, { desc = "Dismiss suggestion" })

  end
}
