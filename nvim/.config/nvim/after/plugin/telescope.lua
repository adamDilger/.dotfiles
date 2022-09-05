local tb = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", tb.find_files)
vim.keymap.set("n", "<leader>fg", tb.live_grep)
vim.keymap.set("n", "<leader>fb", tb.buffers)
vim.keymap.set("n", "<leader>fh", tb.help_tags)
vim.keymap.set("n", "<leader>fd", tb.diagnostics)
vim.keymap.set("v", "<space>fg", function()
	tb.live_grep({ default_text = vim.getVisualSelection() })
end)

vim.api.nvim_create_user_command("Config", function()
	require("telescope.builtin").find_files({
		cwd = "~/.config/nvim",
		hidden = false,
	})
end, {})

function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end
