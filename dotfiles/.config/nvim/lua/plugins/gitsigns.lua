return {
	"lewis6991/gitsigns.nvim",
	opts = {
		numhl = true,
		attach_to_untracked = true,
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")
			local keymap = vim.keymap

			keymap.set(
				"n",
				"<leader>hr",
				gitsigns.reset_hunk,
				{ desc = "Reset hunk (doesn't unstage)", buffer = bufnr }
			)
			keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk", buffer = bufnr })
			keymap.set("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview hunk", buffer = bufnr })
			keymap.set("n", "<leader>gb", gitsigns.blame, { desc = "Git blame", buffer = bufnr })

			keymap.set("n", "<leader>hn", function()
				gitsigns.nav_hunk("next")
			end, { desc = "Next hunk", buffer = bufnr })

			keymap.set("n", "<leader>hp", function()
				gitsigns.nav_hunk("prev")
			end, { desc = "Previous hunk", buffer = bufnr })

			vim.keymap.set("n", "<leader>cb", function()
				local revision = vim.fn.input("Change base to: ", "HEAD")
				if revision ~= "" then
					gitsigns.change_base(revision)
				end
			end, { buffer = bufnr, desc = "Change git base" })

			vim.keymap.set("n", "<leader>gd", function()
				local revision = vim.fn.input("Diff against: ", "HEAD")
				if revision ~= "" then
					gitsigns.diffthis(revision)
				end
			end, { buffer = bufnr, desc = "Diff against revision" })
		end,
	},
}
