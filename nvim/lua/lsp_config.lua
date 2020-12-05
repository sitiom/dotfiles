local lsp = require"lspconfig"

local map = function(type, key, value)
	vim.fn.nvim_buf_set_keymap(0, type, key, value, {
		noremap = true,
		silent = true,
	})
end

local on_attach_common = function(_)
	print("LSP started.")

	-- GOTO mappings
	map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
	map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
	map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
	map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
	map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
	map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
	map("n", "<leader>gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
	map("n", "<leader>gw", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
	map("n", "<leader>gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")

	-- ACTION mappings
	map("n", "<leader>ah", "<cmd>lua vim.lsp.buf.hover()<CR>")
	map("n", "<leader>af", "<cmd>lua vim.lsp.buf.code_action()<CR>")
	map("n", "<leader>ee", "<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>")
	map("n", "<leader>ar", "<cmd>lua vim.lsp.buf.rename()<CR>")

	-- Few language severs support these three
	map("n", "<leader>=", "<cmd>lua vim.lsp.buf.formatting()<CR>")
	map("n", "<leader>ai", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>")
	map("n", "<leader>ao", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>")
end

lsp.vimls.setup{ on_attach = on_attach_common }
lsp.omnisharp.setup{ on_attach = on_attach_common }

local border_chars = {
	TOP_LEFT = "┌",
	TOP_RIGHT = "┐",
	MID_HORIZONTAL = "─",
	ID_VERTICAL = "│",
	BOTTOM_LEFT = "└",
	BOTTOM_RIGHT = "┘",
}
vim.g.lsp_utils_location_opts = {
	height = 24,
	mode = "split",
	list = {
		border = true,
		numbering = true,
	},
	preview = {
		title = "Location Preview",
		border = true,
		border_chars = border_chars,
	},
	keymaps = {
		n = {
			["<C-n>"] = "j",
			["<C-p>"] = "k",
		},
	},
}
vim.g.lsp_utils_symbols_opts = {
	height = 24,
	mode = "editor",
	list = { border = true },
	preview = {
		title = "Symbols Preview",
		border = true,
		border_chars = border_chars,
	},
	keymaps = {
		n = {
			["<C-n>"] = "j",
			["<C-p>"] = "k",
		},
	},
}

vim.lsp.callbacks["textDocument/codeAction"] =
	require"lsputil.codeAction".code_action_handler
vim.lsp.callbacks["textDocument/references"] =
	require"lsputil.locations".references_handler
vim.lsp.callbacks["textDocument/definition"] =
	require"lsputil.locations".definition_handler
vim.lsp.callbacks["textDocument/declaration"] =
	require"lsputil.locations".declaration_handler
vim.lsp.callbacks["textDocument/typeDefinition"] =
	require"lsputil.locations".typeDefinition_handler
vim.lsp.callbacks["textDocument/implementation"] =
	require"lsputil.locations".implementation_handler
vim.lsp.callbacks["textDocument/documentSymbol"] =
	require"lsputil.symbols".document_handler
vim.lsp.callbacks["workspace/symbol"] =
	require"lsputil.symbols".workspace_handler
