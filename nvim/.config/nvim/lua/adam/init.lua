require("adam.set")

_PROJECT = {
	java = {},
}
require("nvim-projectconfig").setup()

require("adam.globals")
require("adam.packer")

require("languages.go")
require("languages.lua")

vim.keymap.set("n", "s", "<cmd>echo 'SAVE'<cr>")
