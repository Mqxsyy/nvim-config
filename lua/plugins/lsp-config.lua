return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup {
				ensure_installed = {
					"lua_ls",
					"ts_ls",

					"biome",
				},
			}
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("lsp").create_capabilities()

			require("lspconfig").lua_ls.setup(capabilities)
			require("lspconfig").biome.setup(capabilities)
			require("lspconfig").ts_ls.setup(capabilities)
			require("lspconfig").bashls.setup(capabilities)
		end,
	},
}
