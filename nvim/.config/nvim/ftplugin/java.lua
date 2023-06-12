-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.

if not _PROJECT.java.ENABLED then
	return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local augroup = vim.api.nvim_create_augroup("LspFormattingJava", {})
local function lsp_formatting()
	require("jdtls").organize_imports()
	vim.lsp.buf.format()
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" })

local home = os.getenv("HOME")
local JDTLS_LOCATION = home .. "/.local/share/nvim/mason/packages/jdtls"
local JAVA_DEBUG_LOCATION = home .. "/.local/share/nvim/lsp_servers/java-debug"
local LOMBOK_JAR_LOCATION = home .. "/.vscode/extensions/gabrielbb.vscode-lombok-1.0.1/server/lombok.jar"
local WORKSPACE_PATH = home .. "/workspace/"

if vim.fn.has("mac") == 1 then
	CONFIG = "mac"
	JAVA_BIN = "/Library/Java/JavaVirtualMachines/temurin-19.jdk/Contents/Home/bin/java"
	JAVA_11_HOME = "/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home/bin/java"
	JAVA_17_HOME = "/Library/Java/JavaVirtualMachines/temurin-19.jdk/Contents/Home/bin/java"
	FORMATTER_XML_LOCATION = home .. "/geo/geometry/standards/eclipse/GeometryFormatter.xml"
elseif vim.fn.has("unix") == 1 then
	CONFIG = "linux"
	JAVA_BIN = "/usr/lib/jvm/temurin-17-jdk-amd64/bin/java"
	JAVA_11_HOME = "/usr/lib/jvm/temurin-11-jdk-amd64"
	JAVA_17_HOME = "/usr/lib/jvm/temurin-17-jdk-amd64"
	FORMATTER_XML_LOCATION = home .. "/dev/geometry/standards/eclipse/GeometryFormatter.xml"
else
	print("Unsupported system")
	return
end

local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local bundles = {}

-- vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.config/nvim/vscode-java-test/server/*.jar"), "\n"))
vim.list_extend(
	bundles,
	vim.split(
		vim.fn.glob(
			JAVA_DEBUG_LOCATION .. "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
		),
		"\n"
	)
)
local config = {
	cmd = {
		JAVA_BIN,

		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-javaagent:" .. LOMBOK_JAR_LOCATION,
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		"-jar",
		JDTLS_LOCATION .. "/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",

		"-configuration",
		JDTLS_LOCATION .. "/config_" .. CONFIG,

		"-data",
		WORKSPACE_PATH .. project_name,
	},

	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	root_dir = root_dir,

	capabilities = capabilities,
	on_attach = function(client, bufnr)
		if client.name == "jdt.ls" then
			-- vim.lsp.codelens.refresh()
			require("jdtls").setup_dap({ hotcodereplace = "auto", verbose = true })
			require("jdtls.dap").setup_dap_main_class_configs({
				config_overrides = {
					vmArgs = _PROJECT.java.vmArgs or nil,
				},
			})
		end

		-- Mappings.
		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, bufopts)
		vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, bufopts)
		vim.keymap.set("v", "<leader>la", vim.lsp.buf.code_action, bufopts)
		vim.keymap.set("n", "<leader>lf", lsp_formatting, bufopts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

		-- add to your shared on_attach callback
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = lsp_formatting,
			})
		end
	end,

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {
			home = JAVA_11_HOME,

			format = {
				enabled = true,
				settings = {
					url = FORMATTER_XML_LOCATION,
				},
			},
		},
	},

	extendedClientCapabilities = extendedClientCapabilities,

	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = bundles,
	},
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(config)
