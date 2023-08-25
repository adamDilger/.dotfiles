-- volar takeover mode
local volarAttached = false
local tsserverAttached = false

local verbose = false
local log = function(...)
	if verbose then
		print(...)
	end
end

local detachTsServer = function()
	log("detaching tsserver")
	local active_clients = vim.lsp.get_active_clients()
	for _, active_client in pairs(active_clients) do
		if active_client.name == "tsserver" then
			log("tsserver stop()")
			active_client.stop()
		end
	end
end

return {
	enableTakoverMode = function()
		log("enableTakoverMode()")

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)

				if client.name == "volar" then
					log("volar attached")
					volarAttached = true
				elseif client.name == "tsserver" then
					log("tsserver attached")
					tsserverAttached = true
				end

				if volarAttached and tsserverAttached then
					detachTsServer()
				end
			end,
		})
	end,
}
