-- Install lazy if it is not already.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Map leader before loading lazy.
vim.g.mapleader = " "

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	defaults = {
		version = "*", -- Get the latest stable version of new plugins
	},
	install = { colorscheme = { "catppuccin-macchiato" } },
	checker = {
		enabled = false, -- Updates :Lazy sync or :Lazy check
	},
	change_detection = {
		enabled = true, -- Check for local changes
		notify = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
