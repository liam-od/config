local function get_file_name()
	return vim.api.nvim_buf_get_name(0)
end

return {
	"mfussenegger/nvim-lint",
	event = { "BufWritePost", "InsertLeave" },
	config = function()
		local lint = require("lint")

		-- Linter name must come from nvim-lint's supported linters
		lint.linters_by_ft = {
			python = { "ruff" },
		}

		lint.linters.ruff.args = {
			"check",
			"--config",
			vim.fn.stdpath("config") .. "/ruff.toml",
			"--force-exclude",
			"--quiet",
			"--stdin-filename",
			get_file_name,
			"--no-fix",
			"--output-format",
			"json",
			"-",
		}

		vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
