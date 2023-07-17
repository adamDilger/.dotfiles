vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<leader>N", "<cmd>NvimTreeFindFileToggle<cr>")

return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup {
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
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
		}
	end,
}

