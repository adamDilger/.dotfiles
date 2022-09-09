require("mason").setup()

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		timeout_ms = 2000,
		name = "null-ls",
		bufnr = bufnr,
	})
end

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- not sure where this is supposed to go, this might not need to be cleared in the for loop either?
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local base_on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("v", "<leader>la", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<leader>lf", function()
		lsp_formatting(bufnr)
	end, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

	-- add to your shared on_attach callback
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end
end

-- Setup lspconfig for nvim-cmp
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

require("lspconfig")["gopls"].setup({
	on_attach = base_on_attach,
	capabilities = capabilities,
})

if not _PROJECT.LSP_SKIP_TAILWIND then
	require("lspconfig")["tailwindcss"].setup({
		on_attach = base_on_attach,
		capabilities = capabilities,
	})
end

-- default to volars ts server, as vue projects are more common than ts ones
if not _PROJECT.LSP_SKIP_VOLAR then
	require("languages.vue").setupVolar(base_on_attach, capabilities)
elseif not _PROJECT.LSP_SKIP_TSSERVER then
	require("lspconfig")["tsserver"].setup({
		on_attach = base_on_attach,
		capabilities = capabilities,
	})
end

require("lspconfig")["sumneko_lua"].setup({
	on_attach = base_on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "_PROJECT" },
			},
		},
	},
})
