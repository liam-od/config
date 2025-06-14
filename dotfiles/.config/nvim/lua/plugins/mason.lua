return {
	"williamboman/mason.nvim",
	config = function()
		local mason = require("mason")
		local mason_registry = require("mason-registry")

		mason.setup({
			ui = {
				icons = {
					packages_installed = "✓",
					packages_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		local ensure_installed = {
			-- LSP
			"lua-language-server",
			"pyright",
			"ansible-language-server",

			-- Formatters
			"stylua",
			"ruff",
			"prettierd",

			-- Linters
			"ansible-lint",
		}

		local function install_packages()
			for _, package_name in ipairs(ensure_installed) do
				local package = mason_registry.get_package(package_name)
				if not package:is_installed() then
					vim.notify("Installing " .. package_name)
					package:install()
				end
			end
		end

		if mason_registry.refresh then
			mason_registry.refresh(install_packages)
		else
			install_packages()
		end
	end,
}
