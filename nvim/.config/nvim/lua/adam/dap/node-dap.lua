-- https://github.com/StevanFreeborn/nvim-config/blob/main/lua/plugins/debugging.lua#L111-L123
-- misc node dap config with some presets

local dap = require("dap")

dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "node",
		args = {
			vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
			"${port}",
		},
	},
}

-- -- this allow us to handle launch.json configurations
-- -- which specify type as "node" or "chrome" or "msedge"
-- dap.adapters[adapterType] = function(cb, config)
-- 	local nativeAdapter = dap.adapters[pwaType]
--
-- 	config.type = pwaType
--
-- 	if type(nativeAdapter) == "function" then
-- 		nativeAdapter(cb, config)
-- 	else
-- 		cb(nativeAdapter)
-- 	end
-- end

-- local enter_launch_url = function()
-- 	local co = coroutine.running()
-- 	return coroutine.create(function()
-- 		vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:" }, function(url)
-- 			if url == nil or url == "" then
-- 				return
-- 			else
-- 				coroutine.resume(co, url)
-- 			end
-- 		end)
-- 	end)
-- end
--
-- for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" }) do
-- 	dap.configurations[language] = {
-- 		{
-- 			name = "Launch via NPM",
-- 			request = "launch",
-- 			runtimeArgs = { "run-script", "dev" },
-- 			cwd = "${workspaceFolder}",
-- 			runtimeExecutable = "npm",
-- 			skipFiles = { "<node_internals>/**" },
-- 			type = "pwa-node",
-- 			console = "integratedTerminal",
-- 		},
--
-- 		{
-- 			type = "pwa-node",
-- 			request = "launch",
-- 			name = "Launch file using Node.js (nvim-dap)",
-- 			program = "${file}",
-- 			cwd = "${workspaceFolder}",
-- 		},
-- 		{
-- 			type = "pwa-node",
-- 			request = "attach",
-- 			name = "Attach to process using Node.js (nvim-dap)",
-- 			processId = require("dap.utils").pick_process,
-- 			cwd = "${workspaceFolder}",
-- 		},
-- 		-- requires ts-node to be installed globally or locally
-- 		{
-- 			type = "pwa-node",
-- 			request = "launch",
-- 			name = "Launch file using Node.js with ts-node/register (nvim-dap)",
-- 			program = "${file}",
-- 			cwd = "${workspaceFolder}",
-- 			runtimeArgs = { "-r", "ts-node/register" },
-- 		},
-- 		{
-- 			type = "pwa-chrome",
-- 			request = "launch",
-- 			name = "Launch Chrome (nvim-dap)",
-- 			url = enter_launch_url,
-- 			webRoot = "${workspaceFolder}",
-- 			sourceMaps = true,
-- 		},
-- 	}
-- end
--
-- return {}
