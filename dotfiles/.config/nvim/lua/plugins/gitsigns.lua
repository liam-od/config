return {
  "lewis6991/gitsigns.nvim",
  opts = {
    numhl = true,
    attach_to_untracked = true,
  },
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')
    local keymap = vim.keymap

    keymap.set('n', '<leader>hr', gitsigns.reset_hunk, { desc = "Reset hunk (doesn't unstage)", buffer = bufnr })
    keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { desc = "Stage hunk", buffer = bufnr })
    keymap.set('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = "Preview hunk", buffer = bufnr })
    keymap.set('n', '<leader>hn', gitsigns.nav_hunk('next'), { desc = "Next hunk", buffer = bufnr })
    keymap.set('n', '<leader>hp', gitsigns.nav_hunk('prev'), { desc = "Previous hunk", buffer = bufnr })
    keymap.set('n', '<leader>hp', gitsigns.nav_hunk('prev'), { desc = "Previous hunk", buffer = bufnr })
    keymap.set('n', '<leader>gb', gitsigns.blame, { desc = "Git blame", buffer = bufnr })

    --change_base main
    --diffthis main

  end
}
