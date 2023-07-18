local format_on_save = true

local group = vim.api.nvim_create_augroup("format_on_save", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
	group = group,
	callback = function()
		if not format_on_save then
			return
		end

		vim.api.nvim_exec2("Neoformat", {})
	end,
})

vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
	format_on_save = not format_on_save

	print("Format on save: " .. tostring(format_on_save))
end, {})

return {
	"sbdchd/neoformat",
	config = function() end,
}
