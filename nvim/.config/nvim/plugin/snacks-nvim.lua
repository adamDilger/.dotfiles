vim.pack.add({ "https://github.com/folke/snacks.nvim" })

local Snacks = require("snacks")

Snacks.setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
	bigfile = { enabled = true },
	-- dashboard = { enabled = true },
	-- explorer = { enabled = true },
	indent = {
		enabled = true,
		scope = {
			hl = "vimCommentTitle",
		},
	},
	-- input = { enabled = true },
	picker = { enabled = true },
	-- notifier = { enabled = true },
	-- quickfile = { enabled = true },
	-- scope = { enabled = true },
	-- scroll = { enabled = true },
	-- statuscolumn = { enabled = true },
	-- words = { enabled = true },
})

-- vim.highlight.create("IndentColour", { default = true }, { ctermbg = "blue" })

vim.keymap.set("n", "<leader>/", Snacks.picker.smart, { desc = "Smart Find Files" })
vim.keymap.set("n", "<leader>s/", Snacks.picker.grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sc", Snacks.picker.pick, { desc = "[S]earch by [P]ickers" })
