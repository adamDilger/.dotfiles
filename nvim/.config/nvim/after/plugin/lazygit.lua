vim.g.floaterm_borderchars = "─│─│╭╮╯╰"
local width = "0.9"
local height = "0.9"
local autoclose = "1"
local command = "lazygit"

local function open_lazygit_popup()
	local c = "FloatermNew --height="
		.. height
		.. " --width="
		.. width
		.. " --autoclose="
		.. autoclose
		.. " "
		.. command

	vim.cmd(c)
end

vim.keymap.set("n", "<leader>gg", open_lazygit_popup, { silent = true })
