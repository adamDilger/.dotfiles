local dap, dapui = require("dap"), require("dapui")

local opts = { silent = true }
vim.keymap.set("n", "<leader>dd", "<Cmd>lua require'dap'.continue()<CR>", opts)
vim.keymap.set("n", "<leader>ds", "<Cmd>lua require'dap'.step_over()<CR>", opts)
vim.keymap.set("n", "<leader>di", "<Cmd>lua require'dap'.step_into()<CR>", opts)
vim.keymap.set("n", "<leader>do", "<Cmd>lua require'dap'.step_out()<CR>", opts)
vim.keymap.set("n", "<Leader>db", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.keymap.set("n", "<Leader>dl", "<Cmd>lua require'dap'.goto_()<CR>", opts)
-- vim.keymap.set("<Leader>dB", "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
-- vim.keymap.set(
-- 	"<Leader>lp",
-- 	"<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
-- 	opts
-- )
-- vim.keymap.set("<Leader>dr", "<Cmd>lua require'dap'.repl.open()<CR>", opts)
-- vim.keymap.set("<Leader>dl", "<Cmd>lua require'dap'.run_last()<CR>", opts)

dapui.setup({})
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
