return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = ":TSUpdate",
	config = function()
		local languages = {
			"lua",
			"python",
			"javascript",
			"typescript",
			"tsx",
			"yaml",
			"json",
			"html",
			"css",
			"markdown",
			"markdown_inline",
			"bash",
			"vim",
			"dockerfile",
			"gitignore",
			"regex",
			"latex",
		}

		require("nvim-treesitter").setup({})
		require("nvim-treesitter").install({ unpack(languages) })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = languages,
			callback = function()
				vim.treesitter.start()
				-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
				-- vim.wo.foldmethod = 'expr'
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

				vim.bo.smartindent = false
				vim.bo.cindent = false
				vim.bo.autoindent = true
			end,
		})

		-- LaTeX: filetype is "tex" but parser name is "latex"
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "tex",
			callback = function()
				vim.treesitter.start(0, "latex")
			end,
		})
	end,
}
