return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	opts = {
		keymap = {},
		completion = {},
		sources = {
			per_filetype = {
				tex = { "lsp" },
			},
			providers = {
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
