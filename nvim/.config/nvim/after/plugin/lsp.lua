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
	vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, bufopts)
	vim.keymap.set("n", "<leader>lf", function()
		lsp_formatting(bufnr)
	end, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

	-- add to your shared on_attach callback
	if client.supports_method("textDocument/formatting") or (client.name == "volar" and _PROJECT.PRETTIER) then
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
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig")["gopls"].setup({
	on_attach = base_on_attach,
	capabilities = capabilities,
})

if _PROJECT.TAILWIND then
	require("lspconfig")["tailwindcss"].setup({
		on_attach = base_on_attach,
		capabilities = capabilities,
	})
end

require("lspconfig")["astro"].setup({
	on_attach = base_on_attach,
	capabilities = capabilities,
})

require("lspconfig")["rust_analyzer"].setup({
	on_attach = base_on_attach,
	capabilities = capabilities,
})

-- default to volars ts server, as vue projects are more common than ts ones
if _PROJECT.VOLAR then
	-- require("languages.vue").setupVolar(base_on_attach, capabilities)
	require("lspconfig")["volar"].setup({
		on_attach = base_on_attach,
		capabilities = capabilities,
		filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
	})
elseif _PROJECT.DENO then
	require("lspconfig")["denols"].setup({
		on_attach = base_on_attach,
		capabilities = capabilities,
		init_options = {
			lint = true,
		},
	})
else
	require("lspconfig")["tsserver"].setup({
		on_attach = base_on_attach,
		capabilities = capabilities,
	})
end

require("lspconfig")["lua_ls"].setup({
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

if _PROJECT.EMMET then
	require("lspconfig").emmet_ls.setup({
		-- on_attach = on_attach,
		capabilities = capabilities,
		filetypes = { "html", "freemarker", "vue" },
		-- init_options = {
		-- 	html = {
		-- 		options = {
		-- 			-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
		-- 			["bem.enabled"] = true,
		-- 		},
		-- 	},
		-- },
	})
end
