-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("lua-maps", { clear = true })

-- add to your shared on_attach callback
vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup,
	pattern = "*.lua",
	callback = function(opts)
		vim.keymap.set("n", "<leader><leader>x", "<cmd>luafile %<cr>", { buffer = opts.buf })
	end,
})
