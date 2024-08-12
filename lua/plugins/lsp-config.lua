local function create_capabilities()
	local capabilities = vim.tbl_deep_extend(
		"force",
		vim.lsp.protocol.make_client_capabilities(),
		require("cmp_nvim_lsp").default_capabilities()
	)

	return vim.tbl_deep_extend("force", capabilities, {
		workspace = {
			didChangeWatchedFiles = {
				dynamicRegistration = true,
			},
		},
	})
end

local capabilities = create_capabilities()

return {
	{
		"lopi-py/luau-lsp.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("luau-lsp").setup({
				platform = {
					type = "roblox",
				},
				types = {
					roblox_security_level = "PluginSecurity",
				},
				sourcemap = {
					enabled = true,
					autogenerate = true,
					rojo_project_file = "default.project.json",
				},
				server = {
					capabilities = capabilities,
					settings = {
						["luau-lsp"] = {
							completion = {
								imports = {
									enabled = true,
									suggestServices = true,
									suggestRequires = true,
								},
							},
						},
					},
				},
			})
		end,
	},
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
				},
			})

			require("mason-lspconfig").setup_handlers({
				luau_lsp = function() end,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lspconfig").lua_ls.setup({
				capabilities = capabilities,
			})

			require("lspconfig").tsserver.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
