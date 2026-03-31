-- Useful plugin to show you pending keybinds.
vim.pack.add({ "https://github.com/folke/which-key.nvim" })

-- event = "VimEnter",
-- ---@module 'which-key'
-- ---@type wk.Opts
-- ---@diagnostic disable-next-line: missing-fields

require("which-key").setup({
	-- delay between pressing a key and opening which-key (milliseconds)
	delay = 100,
	icons = { mappings = vim.g.have_nerd_font },

	-- Document existing key chains
	spec = {
		{ "<leader>s", group = "[S]earch", mode = { "n", "v" } },
		{ "<leader>t", group = "[T]oggle" },
		{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } }, -- Enable gitsigns recommended keymaps first
		{ "gr", group = "LSP Actions", mode = { "n" } },
	},
})
