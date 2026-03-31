vim.pack.add({
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/navarasu/onedark.nvim",
})

-- vim.cmd("colorscheme kanagawa-dragon")

require("onedark").setup({
	style = "warmer" --[[ darker ]],
})
require("onedark").load()
vim.cmd.colorscheme("onedark")
