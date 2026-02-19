return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			yaml = { "prettierd" },
			python = { "ruff_format" },
			tex = { "latexindent" },
		},
		formatters = {
			latexindent = {
				args = { "-c", "/tmp/", "-" },
			},
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
}
