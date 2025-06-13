local function find_root()
	local root = vim.fs.find({ ".git" }, { upward = true, type = "directory", stop = vim.fn.expand("~"), limit = 1 })
	return vim.fs.dirname(unpack(root)) or vim.fn.getcwd()
end

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		dashboard = {
			preset = {
				pick = function(cmd, opts)
					return LazyVim.pick(cmd, opts)()
				end,
				header = [[
        ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
        ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
        ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
        ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
        ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║           
        ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝           
 ]],
				keys = {

					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
		},
		bigfile = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		statuscolumn = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		explorer = {
			replace_netrw = true,
		},
		picker = {
			ui_select = true,
			sources = {
				explorer = {
					exclude = { ".venv/", "undodir/", ".git/" },
					win = {
						list = {
							keys = {
								["<c-t>"] = { "edit_tab", mode = { "n", "i" } },
							},
						},
					},
				},
				files = {
					hidden = true,
					ignored = true,
					exclude = { ".venv/", "undodir/", ".git/" },
				},
			},
		},
		quickfile = {
			exclude = { "lua", "python", "latex", "tex" },
		},
		gitbrowse = {
			remote_patterns = {
				{ "^git@(.+)-enki:(.+)%.git$", "https://%1/%2" },
				{ "^(https?://.*)%.git$", "%1" },
				{ "^git@(.+):(.+)%.git$", "https://%1/%2" },
				{ "^git@(.+):(.+)$", "https://%1/%2" },
				{ "^git@(.+)/(.+)$", "https://%1/%2" },
				{ "^org%-%d+@(.+):(.+)%.git$", "https://%1/%2" },
				{ "^ssh://git@(.*)$", "https://%1" },
				{ "^ssh://([^:/]+)(:%d+)/(.*)$", "https://%1/%3" },
				{ "^ssh://([^/]+)/(.*)$", "https://%1/%2" },
				{ "ssh%.dev%.azure%.com/v3/(.*)/(.*)$", "dev.azure.com/%1/_git/%2" },
				{ "^https://%w*@(.*)", "https://%1" },
				{ "^git@(.*)", "https://%1" },
				{ ":%d+", "" },
				{ "%.git$", "" },
			},
		},
	},
	keys = {
		{
			"<leader>ff",
			function()
				Snacks.picker.files({ cwd = find_root() })
			end,
			desc = "Find Files",
		},
		{
			"<leader>fs",
			function()
				Snacks.picker.grep({ cwd = find_root() })
			end,
			desc = "Grep",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.files({ cwd = "~/" })
			end,
			desc = "Find Files",
		},
		{
			"<leader>e",
			function()
				Snacks.explorer()
			end,
			desc = "File Explorer",
		},
		{
			"<leader>n",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Notification History",
		},
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>gl",
			function()
				Snacks.lazygit.log()
			end,
			desc = "Lazygit log view",
		},
		{
			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
			mode = { "n", "v" },
		},
	},
}
