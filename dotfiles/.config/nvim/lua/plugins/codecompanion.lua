return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		strategies = {
			chat = {
				adapter = "copilot",
				model = "claude-sonnet-4",
			},
			inLine = {
				adapter = "copilot",
				model = "claude-sonnet-4",
			},
		},
	},
}
