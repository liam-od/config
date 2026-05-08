return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	opts = {
		keymap = {
			["<C-d>"] = { "show_documentation", "fallback" },
		},
		completion = {
			documentation = { auto_show = false },
			ghost_text = { enabled = false },
		},
		signature = { enabled = true },
		sources = {
			per_filetype = {
				tex = { "lsp" },
			},
			providers = {
				buffer = {
					score_offset = 5,
				},
				lsp = {
					min_keyword_length = function(ctx)
						if vim.bo.filetype == "tex" then
							-- Block keyword completions
							return ctx.trigger.initial_kind == "trigger_character" and 0 or 100
						end
						return 0
					end,
				},
			},
		},
	},
}
