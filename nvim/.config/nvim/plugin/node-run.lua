-- node-run.lua
-- :Js command — runs the current buffer through node and shows output in a vertical split.
-- The output buffer auto-updates whenever the source buffer changes (debounced).

local ns = vim.api.nvim_create_namespace("node_run")
local augroup = vim.api.nvim_create_augroup("node_run", { clear = true })

--- State keyed by source buffer number
--- state[src_buf] = { out_buf, win, timer }
local state = {}

--- Write lines into the output buffer (must be called in the main loop)
local function set_output(out_buf, lines)
	if not vim.api.nvim_buf_is_valid(out_buf) then
		return
	end
	vim.bo[out_buf].modifiable = true
	vim.api.nvim_buf_set_lines(out_buf, 0, -1, false, lines)
	vim.bo[out_buf].modifiable = false
end

--- Run the source buffer content through node and push results to out_buf
local function run(src_buf, out_buf)
	if not vim.api.nvim_buf_is_valid(src_buf) or not vim.api.nvim_buf_is_valid(out_buf) then
		return
	end

	local lines = vim.api.nvim_buf_get_lines(src_buf, 0, -1, false)
	local code = table.concat(lines, "\n")

	local stdout_lines = {}
	local stderr_lines = {}

	local ft = vim.bo[src_buf].filetype
	local input_type = (ft == "typescript" or ft == "typescriptreact") and "module-typescript" or "module"

	vim.fn.jobstart({ "node", "--input-type=" .. input_type, "-e", code }, {
		stdin = "null",
		stdout_buffered = true,
		stderr_buffered = true,
		on_stdout = function(_, data)
			for _, line in ipairs(data) do
				if line ~= "" then
					table.insert(stdout_lines, line)
				end
			end
		end,
		on_stderr = function(_, data)
			for _, line in ipairs(data) do
				if line ~= "" then
					table.insert(stderr_lines, line)
				end
			end
		end,
		on_exit = function(_, code_exit)
			vim.schedule(function()
				local out = {}
				if #stdout_lines > 0 then
					vim.list_extend(out, stdout_lines)
				end
				if #stderr_lines > 0 then
					if #out > 0 then
						table.insert(out, "")
					end
					vim.list_extend(out, stderr_lines)
				end
				if #out == 0 then
					out = { "(no output)" }
				end
				set_output(out_buf, out)
			end)
		end,
	})
end

--- Schedule a debounced run (300 ms)
local function schedule_run(src_buf)
	local s = state[src_buf]
	if not s then
		return
	end
	if s.timer then
		s.timer:stop()
	end
	s.timer = vim.defer_fn(function()
		run(src_buf, s.out_buf)
	end, 300)
end

--- Create (or focus) the output window for the given source buffer
local function open_output_win(src_buf)
	-- Reuse existing state if output buf/win are still valid
	local s = state[src_buf]
	if s then
		local buf_ok = vim.api.nvim_buf_is_valid(s.out_buf)
		local win_ok = s.win and vim.api.nvim_win_is_valid(s.win)
		if buf_ok and win_ok then
			vim.api.nvim_set_current_win(s.win)
			vim.api.nvim_set_current_win(vim.fn.bufwinid(src_buf))
			return
		end
		-- buf exists but window was closed — reopen
		if buf_ok then
			vim.cmd("vsplit")
			local new_win = vim.api.nvim_get_current_win()
			vim.api.nvim_win_set_buf(new_win, s.out_buf)
			s.win = new_win
			vim.api.nvim_set_current_win(vim.fn.bufwinid(src_buf))
			return
		end
	end

	-- Fresh setup
	local out_buf = vim.api.nvim_create_buf(false, true)
	vim.bo[out_buf].buftype = "nofile"
	vim.bo[out_buf].bufhidden = "wipe"
	vim.bo[out_buf].swapfile = false
	vim.bo[out_buf].filetype = "node_run_output"
	vim.api.nvim_buf_set_name(out_buf, "node://output[" .. src_buf .. "]")

	-- Open vertical split to the right
	vim.cmd("vsplit")
	local out_win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_buf(out_win, out_buf)

	-- Make the output window read-only and clean
	vim.wo[out_win].number = false
	vim.wo[out_win].relativenumber = false
	vim.wo[out_win].signcolumn = "no"
	vim.wo[out_win].wrap = true

	-- Return focus to source buffer
	vim.api.nvim_set_current_win(vim.fn.bufwinid(src_buf))

	state[src_buf] = { out_buf = out_buf, win = out_win, timer = nil, change_au = nil }

	-- Watch for output window being closed
	vim.api.nvim_create_autocmd("WinClosed", {
		group = augroup,
		pattern = tostring(out_win),
		once = true,
		callback = function()
			local entry = state[src_buf]
			if entry then
				if entry.timer then
					entry.timer:stop()
				end
				if entry.change_au then
					pcall(vim.api.nvim_del_autocmd, entry.change_au)
					entry.change_au = nil
				end
				entry.win = nil
			end
		end,
	})

	-- Tear down when source buffer is unloaded
	vim.api.nvim_create_autocmd("BufUnload", {
		group = augroup,
		buffer = src_buf,
		once = true,
		callback = function()
			local entry = state[src_buf]
			if entry then
				if entry.timer then
					entry.timer:stop()
				end
				if vim.api.nvim_buf_is_valid(entry.out_buf) then
					vim.api.nvim_buf_delete(entry.out_buf, { force = true })
				end
			end
			state[src_buf] = nil
		end,
	})

	-- Auto-run on text change (store ID so it can be removed when output win closes)
	state[src_buf].change_au = vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
		group = augroup,
		buffer = src_buf,
		callback = function()
			schedule_run(src_buf)
		end,
	})
end

vim.api.nvim_create_user_command("Js", function()
	local src_buf = vim.api.nvim_get_current_buf()
	if vim.bo[src_buf].filetype ~= "typescript" and vim.bo[src_buf].filetype ~= "typescriptreact" then
		vim.bo[src_buf].filetype = "typescript"
	end
	open_output_win(src_buf)
	run(src_buf, state[src_buf].out_buf)
end, { desc = "Run current buffer through node and show output in a vertical split" })
