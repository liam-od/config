local function on_attach(_, bufnr)
	local opts = { buffer = bufnr, silent = true }
	local keymap = vim.keymap

	keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
	keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	keymap.set("n", "gr", Snacks.picker.lsp_references, opts)
end

vim.diagnostic.config({
	virtual_text = false,
	float = { border = "rounded" },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.yml", "*.yaml" },
	callback = function()
		if
			vim.fs.find({ "ansible.cfg" }, {
				upward = true,
				type = "file",
				stop = vim.fn.expand("~"),
				limit = 1,
			})[1]
		then
			vim.bo.filetype = "yaml.ansible"
		end
	end,
})

vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim", "Snacks", "MiniIcons", "LazyVim" } },
			workspace = {
				checkThirdParty = false,
				library = {
					unpack(vim.api.nvim_get_runtime_file("", true)),
				},
			},
		},
	},
})

vim.lsp.config("basedpyright", {
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	on_attach = on_attach,
	settings = {
		basedpyright = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly",
				useLibraryCodeForTypes = true,
			},
		},
	},
})

vim.lsp.config("pyright", {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	on_attach = on_attach,
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "openFilesOnly",
				useLibraryCodeForTypes = true,
			},
		},
	},
})

vim.lsp.config("ansiblels", {
	cmd = { "ansible-language-server", "--stdio" },
	filetypes = { "yaml.ansible" },
	root_markers = { "ansible.cfg" },
	on_attach = on_attach,
})

vim.lsp.config("texlab", {
	cmd = { "texlab" },
	filetypes = { "tex", "bib" },
	root_markers = { ".latexmkrc", ".git" },
	on_attach = on_attach,
})

vim.lsp.enable({
	"lua_ls",
	"pyright",
	"ansiblels",
	"texlab",
	-- 'basedpyright',
})
