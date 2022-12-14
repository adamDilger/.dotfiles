local dap, dapui = require("dap"), require("dapui")

require("nvim-dap-virtual-text").setup()

local opts = { silent = true }
vim.keymap.set("n", "<leader>dd", "<Cmd>lua require'dap'.continue()<CR>", opts)
vim.keymap.set("n", "<leader>ds", "<Cmd>lua require'dap'.step_over()<CR>", opts)
vim.keymap.set("n", "<leader>di", "<Cmd>lua require'dap'.step_into()<CR>", opts)
vim.keymap.set("n", "<leader>do", "<Cmd>lua require'dap'.step_out()<CR>", opts)
vim.keymap.set("n", "<Leader>db", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.keymap.set("n", "<Leader>dl", "<Cmd>lua require'dap'.run_to_cursor()<CR>", opts)
vim.keymap.set("n", "<Leader>dc", "<Cmd>lua require('dap').terminate()<CR>", opts)

-- vim.keymap.set("<Leader>dB", "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
-- vim.keymap.set(
-- 	"<Leader>lp",
-- 	"<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
-- 	opts
-- )
-- vim.keymap.set("<Leader>dr", "<Cmd>lua require'dap'.repl.open()<CR>", opts)
-- vim.keymap.set("<Leader>dl", "<Cmd>lua require'dap'.run_last()<CR>", opts)

dapui.setup({
	layouts = {
		{
			elements = {
				-- Elements can be strings or table with id and size keys.
				{ id = "scopes", size = 0.30 },
				"breakpoints",
				"stacks",
				"watches",
			},
			size = 40,
			position = "left",
		},
		{
			elements = {
				"console",
			},
			size = 0.30,
			position = "bottom",
		},
	},
})
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
	vim.keymap.set("n", "E", "<Cmd>lua require('dapui').eval()<CR>")
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	-- dapui.close()
	-- vim.keymap.del("n", "E")
end
dap.listeners.before.event_exited["dapui_config"] = function()
	-- dapui.close()
	-- vim.keymap.del("n", "E")
end

vim.api.nvim_create_user_command("DO", require("dapui").open, {})
vim.api.nvim_create_user_command("DC", require("dapui").close, {})
