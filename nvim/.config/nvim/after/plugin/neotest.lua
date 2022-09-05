local nt = require("neotest")

nt.setup({
	adapters = {
		require("neotest-go"),
	},
})

vim.keymap.set("n", "<leader>tt", nt.run.run)
vim.keymap.set("n", "<leader>tf", function()
	nt.run.run(vim.fn.expand("%"))
	nt.summary.open()
end)
vim.keymap.set("n", "<leader>td", function()
	require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
end)
