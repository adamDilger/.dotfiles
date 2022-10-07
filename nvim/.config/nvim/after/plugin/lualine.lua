require("lualine").setup({
	sections = {
		lualine_c = { "require('lsp-status').status()", "filename" },
	},
	-- options = {
	-- 	theme = "gruvbox",
	-- },
})
