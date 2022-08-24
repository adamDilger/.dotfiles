vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("go-format", { clear = true }),
	pattern = "*.go",
	callback = vim.lsp.buf.formatting
})

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.goimports
	},
})
