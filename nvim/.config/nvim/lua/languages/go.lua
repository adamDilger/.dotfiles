local dap = require("dap")

dap.adapters.go = function(callback, config)
	local stdout = vim.loop.new_pipe(false)
	local handle
	local pid_or_err
	local host = config.host or "127.0.0.1"
	local port = config.port or "38697"
	local addr = string.format("%s:%s", host, port)
	local opts = {
		stdio = { nil, stdout },
		args = { "dap", "-l", addr },
		detached = true,
	}
	handle, pid_or_err = vim.loop.spawn(os.getenv("HOME") .. "/.local/share/nvim/mason/bin/dlv", opts, function(code)
		stdout:close()
		handle:close()
		if code ~= 0 then
			print("dlv exited with code", code)
		end
	end)
	assert(handle, "Error running dlv: " .. tostring(pid_or_err))
	stdout:read_start(function(err, chunk)
		assert(not err, err)
		if chunk then
			vim.schedule(function()
				require("dap.repl").append(chunk)
			end)
		end
	end)
	-- Wait for delve to start
	vim.defer_fn(function()
		callback({ type = "server", host = "127.0.0.1", port = port })
	end, 100)
end

dap.configurations.go = {
	{
		type = "go",
		name = "Debug Package",
		request = "launch",
		program = "main.go",
	},
}
