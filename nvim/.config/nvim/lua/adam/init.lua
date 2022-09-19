require("adam.set")

require("adam.globals")
require("adam.packer")

require("adam.project_config")

require("languages.go")
require("languages.lua")

vim.keymap.set("n", "s", "<cmd>echo 'SAVE'<cr>")
vim.api.nvim_create_user_command("ProjectConfig", function()
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	vim.cmd([[sp ~/.config/nvim/projects/]] .. project_name .. [[.lua]])
end, {})
