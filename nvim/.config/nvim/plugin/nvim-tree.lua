vim.pack.add({
	"https://github.com/nvim-tree/nvim-tree.lua",
	"https://github.com/nvim-tree/nvim-web-devicons",
})

require("nvim-web-devicons").setup({})
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
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
})

vim.keymap.set("n", "<leader>n", function()
	local api = require("nvim-tree.api")
	api.tree.toggle()
end)

vim.keymap.set("n", "<leader>N", function()
	local api = require("nvim-tree.api")
	api.tree.open({ find_file = true, update_root = true })
end)
