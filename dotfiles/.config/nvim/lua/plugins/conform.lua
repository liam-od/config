return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true })
			end,
			mode = "v",
			desc = "Format selection",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			yaml = { "prettierd" },
			tex = { "latexindent" },
			python = { "ruff_organize_imports", "ruff_format" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			javascript = { "prettierd" },
			javascriptreact = { "prettierd" },
		},
		formatters = {
			latexindent = {
				args = { "-c", "/tmp/", "-" },
			},
		},
		format_on_save = function(bufnr)
			local ft = vim.bo[bufnr].filetype
			if ft == "python" then
				return { formatters = { "ruff_organize_imports" }, timeout_ms = 500 }
			end
			local auto_format = { lua = true, yaml = true, tex = true }
			if not auto_format[ft] then
				return nil
			end
			return { timeout_ms = 500, lsp_format = "fallback" }
		end,
	},
}
