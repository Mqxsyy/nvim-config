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
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"luau_lsp",
					"tsserver",

					"biome",
				},
			})

			--require("mason-lspconfig").setup_handlers({
			--luau_lsp = function() end,
			--})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("lsp").create_capabilities()

			require("lspconfig").lua_ls.setup({
				capabilities = capabilities,
			})

			require("lspconfig").tsserver.setup({
				capabilities = capabilities,
			})

			require("lspconfig").biome.setup({
				capabilities = capabilities,
			})

			local function map(mode, lhs, rhs)
				vim.keymap.set(mode, lhs, rhs, {})
			end

			map("n", "gd", vim.lsp.buf.definition)
			map("n", "gD", vim.lsp.buf.declaration)
			map("n", "gr", vim.lsp.buf.references)
			map("n", "K", vim.lsp.buf.hover)
			map("n", "<leader>r", vim.lsp.buf.rename)
			map("n", "<leader>ca", vim.lsp.buf.code_action)

			map("n", "<leader>e", vim.diagnostic.open_float)
		end,
	},
}
