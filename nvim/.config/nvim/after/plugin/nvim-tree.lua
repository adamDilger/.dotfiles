require("nvim-tree").setup({
	renderer = {
		indent_markers = {
			enable = true,
		},
		icons = {
			git_placement = "after",
			glyphs = {
				git = {
					unstaged = "~",
				},
			},
		},
	},
})

vim.keymap.set("n", "<leader>o", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<leader>O", "<cmd>NvimTreeFindFileToggle<cr>")
