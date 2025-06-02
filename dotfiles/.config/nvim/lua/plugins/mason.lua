return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
  config = function()
    local mason = require("mason")
    local mason_lsp = require("mason-lspconfig")
    local mason_tool = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					packages_installed = "✓",
					packages_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

    mason_lsp.setup({
      ensure_installed = {
        "lua_ls",
      },
      automatic_installation = true,
    })

    mason_tool.setup({
      ensure_installed = {

      },
    })
  end,
}
