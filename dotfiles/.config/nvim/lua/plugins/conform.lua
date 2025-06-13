return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
		},
		format_on_save = {
			timeot_ms = 500,
			lsp_format = "fallback",
		},
	},
	keys = {
		{
			"<leader>mp",
			function()
				require("conform").format({
					formatters = { "ruff_format" },
					async = true,
				})
			end,
			mode = { "n", "x" },
			desc = "Format buffer or selection",
		},
	},
}
