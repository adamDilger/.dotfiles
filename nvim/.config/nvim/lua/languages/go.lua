local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.stylua,
	},
})

require('dap-go').setup()

local dap = require("dap")

--  https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#go-using-delve-directly
dap.adapters.go = function(callback, _)
	local stdout = vim.loop.new_pipe(false)
	local handle, pid_or_err
	local port = 38697

	handle, pid_or_err = vim.loop.spawn("dlv", {
		stdio = { nil, stdout },
		args = { "dap", "-l", "127.0.0.1:" .. port },
		detached = true,
	}, function(code)
		stdout:close()
		handle:close()

		print("[delve] Exit Code:", code)
	end)

	assert(handle, "Error running dlv: " .. tostring(pid_or_err))

	stdout:read_start(function(err, chunk)
		assert(not err, err)

		if chunk then
			vim.schedule(function()
				require("dap.repl").append(chunk)
				print("[delve]", chunk)
			end)
		end
	end)

	-- Wait for delve to start
	vim.defer_fn(function()
		callback { type = "server", host = "127.0.0.1", port = port }
	end, 100)
end
