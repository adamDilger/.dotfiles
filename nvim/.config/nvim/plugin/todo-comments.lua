-- Highlight todo, notes, etc in comments

vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/folke/todo-comments.nvim",
})

--		event = "VimEnter",
--		dependencies = { "nvim-lua/plenary.nvim" },

---@module 'todo-comments'
---@type TodoOptions
---@diagnostic disable-next-line: missing-fields
require("todo-comments").setup({
	signs = false,
})
