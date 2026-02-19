local keymap = vim.keymap

keymap.set("n", "zz", ":write<CR>", { desc = "Save current file", silent = true })
keymap.set("v", "<C-c>", '"+y', { desc = "Copy to system clipboard (Visual)", silent = true })

-- TODO: this needs a rework
keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Navigate to window left", silent = true })
keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Navigate to window down", silent = true })
keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Navigate to window up", silent = true })
keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Navigate to window right", silent = true })
keymap.set("t", "<C-w><C-w>", "<C-\\><C-n><C-w><C-w>", { desc = "Switch window focus from terminal", silent = true })

-- gt goes to next tab <x>gt goes tab number x, i.e 2gt.
-- gT goes to previous tab
keymap.set("n", "tn", ":tabnew<CR>", { desc = "Create new tab" })
