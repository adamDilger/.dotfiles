local function find_dap_terminal_buffer_number()
	for b in pairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(b) then
			local name = vim.api.nvim_buf_get_name(b)
			if string.find(name, "%[dap%-terminal%]") then
				return b
			end
		end
	end

	return nil
end

local function open_dap_terminal_tab()
	local bufnr = find_dap_terminal_buffer_number()
	if bufnr then
		vim.cmd("tabnew #" .. bufnr)
	else
		print("no dap-terminal found")
	end
end

vim.api.nvim_create_user_command("DT", open_dap_terminal_tab, {})
