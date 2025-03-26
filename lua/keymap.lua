local map = require "utils.map"

local exported = {}

--> LspConfig
map("n", "gd", vim.lsp.buf.definition)
map("n", "gD", vim.lsp.buf.declaration)
map("n", "gr", vim.lsp.buf.references)
map("n", "K", vim.lsp.buf.hover)
map("n", "<leader>r", vim.lsp.buf.rename)
map("n", "<leader>ca", vim.lsp.buf.code_action)

map("n", "<leader>e", vim.diagnostic.open_float)

--> Nonels
map("n", "<leader>ff", vim.lsp.buf.format, {})

--> Cmp
exported.cmp = {
	complete = "<C-Space>",
	select_next_item = "<C-j>",
	select_prev_item = "<C-k>",
	confirm = "<CR>",
}

--> Flash
exported.flash = {
	jump = {
		key = "s",
		mode = { "n", "x", "o" },
	},
	treesitter = {
		key = "S",
		mode = { "n", "x", "o" },
	},
	remote = {
		key = "r",
		mode = { "o" },
	},
}

--> Namu
map("n", "<leader>s", ":Namu symbols<cr>", { silent = true })

--> Export
return exported
