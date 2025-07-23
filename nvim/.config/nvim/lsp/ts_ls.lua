return {
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vim.env.FNM_MULTISHELL_PATH .. "/lib/node_modules/@vue/typescript-plugin",
				languages = { "javascript", "typescript", "vue" },
			},
		},
	},
	filetypes = { "javascript", "typescript", "vue" },
}
