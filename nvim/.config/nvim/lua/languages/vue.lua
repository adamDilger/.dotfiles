local lspconfig = require("lspconfig")
local lspconfig_configs = require("lspconfig.configs")
local lspconfig_util = require("lspconfig.util")

local volar_cmd = { "vue-language-server", "--stdio" }
local volar_root_dir = lspconfig_util.root_pattern("package.json")
local ts_server_path = os.getenv("HOME")
	.. "/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib"

-- - serverPath: '/usr/local/lib/node_modules/typescript/lib/tsserverlibrary.js'
-- - localizedPath: '/usr/local/lib/node_modules/typescript/lib/ja/diagnosticMessages.generated.json'
-- + tsdk: '/usr/local/lib/node_modules/typescript/lib'

lspconfig_configs.volar_api = {
	default_config = {
		cmd = volar_cmd,
		root_dir = volar_root_dir,
		filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
		init_options = {
			typescript = { tsdk = ts_server_path },
			languageFeatures = {
				implementation = true, -- new in @volar/vue-language-server v0.33
				references = true,
				definition = true,
				typeDefinition = true,
				callHierarchy = true,
				hover = true,
				rename = true,
				renameFileRefactoring = true,
				signatureHelp = true,
				codeAction = true,
				workspaceSymbol = true,
				completion = {
					defaultTagNameCase = "both",
					defaultAttrNameCase = "kebabCase",
					getDocumentNameCasesRequest = false,
					getDocumentSelectionRequest = false,
				},
			},
		},
	},
}

lspconfig_configs.volar_doc = {
	default_config = {
		cmd = volar_cmd,
		root_dir = volar_root_dir,
		filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
		init_options = {
			typescript = { tsdk = ts_server_path },
			languageFeatures = {
				implementation = true, -- new in @volar/vue-language-server v0.33
				documentHighlight = true,
				documentLink = true,
				codeLens = { showReferencesNotification = true },
				-- not supported - https://github.com/neovim/neovim/pull/15723
				semanticTokens = false,
				diagnostics = true,
				schemaRequestService = true,
			},
		},
	},
}

lspconfig_configs.volar_html = {
	default_config = {
		cmd = volar_cmd,
		root_dir = volar_root_dir,
		filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
		init_options = {
			typescript = { tsdk = ts_server_path },
			documentFeatures = {
				selectionRange = true,
				foldingRange = true,
				linkedEditingRange = true,
				documentSymbol = true,
				-- not supported - https://github.com/neovim/neovim/pull/13654
				documentColor = false,
				documentFormatting = {
					defaultPrintWidth = 100,
				},
			},
		},
	},
}

local setupVolar = function(base_on_attach, capabilities)
	lspconfig.volar_api.setup({ on_attach = base_on_attach, capabilities = capabilities })
	lspconfig.volar_doc.setup({ on_attach = base_on_attach, capabilities = capabilities })
	lspconfig.volar_html.setup({ on_attach = base_on_attach, capabilities = capabilities })
end

return {
	setupVolar = setupVolar,
}
