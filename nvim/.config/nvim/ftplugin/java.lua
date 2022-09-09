-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = "/Users/adamdilger/.local/share/jdtls-workspace/" .. project_name

local augroup = vim.api.nvim_create_augroup("LspFormattingJava", {})
local lsp_formatting = function()
	vim.lsp.buf.formatting_sync()
	require("jdtls").organize_imports()
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" })

--"/path/to/jdtls_install_location/plugins/org.eclipse.equinox.launcher_VERSION_NUMBER.jar",
local install_location = "/Users/adamdilger/.local/share/nvim/mason/packages/jdtls"

local bundles = {}

-- vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.config/nvim/vscode-java-test/server/*.jar"), "\n"))
vim.list_extend(
	bundles,
	vim.split(
		vim.fn.glob(
			"/Users/adamdilger/dev/vscode-java/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
		),
		"\n"
	)
)

P(bundles)

local config = {
	cmd = {

		-- "java", -- or '/path/to/java17_or_newer/bin/java'
		"/Library/Java/JavaVirtualMachines/temurin-18.jdk/Contents/Home/bin/java",

		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-javaagent:/Users/adamdilger/.vscode/extensions/gabrielbb.vscode-lombok-1.0.1/server/lombok.jar",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		"-jar",
		install_location .. "/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",

		"-configuration",
		install_location .. "/config_mac",

		"-data",
		workspace_dir,
	},

	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	root_dir = root_dir,

	capabilities = capabilities,
	on_attach = function(client, bufnr)
		if client.name == "jdt.ls" then
			-- vim.lsp.codelens.refresh()
			require("jdtls").setup_dap({ hotcodereplace = "auto" })
			require("jdtls.dap").setup_dap_main_class_configs()
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
		vim.keymap.set("n", "<leader>lf", function()
			lsp_formatting()
		end, bufopts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

		-- add to your shared on_attach callback
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					lsp_formatting()
				end,
			})
		end
	end,

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {
			home = "/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home",

			format = {
				enabled = true,
				settings = {
					url = "/Users/adamdilger/geo/geometry/standards/eclipse/GeometryFormatter.xml",
				},
			},
		},
	},

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

-- require("dap").configurations.java = {
-- 	{
-- 		name = "GEP HELLO",
-- 		request = "launch",
-- 		type = "java",
-- 		mainClass = "au.com.geometry.gep.GepApplication",
-- 		projectName = "gep",
-- 		vmArgs = {
-- 			"-Dserver.port=8088",
-- 			"-Dspring.output.ansi.enabled=ALWAYS",
-- 			"-Dspring.datasource.username=postgres",
-- 			"-Dspring.datasource.password=devpassword",
-- 			"-Dspring.datasource.driver-class-name=org.postgresql.Driver",
-- 			"-Dspring.datasource.hikari.schema=public",
-- 			"-Dspring.datasource.hikari.maximum-pool-size=10",
-- 			"-Dhibernate.dialect=au.com.geometry.gep.db.dialect.Postgis10DialectWithJSON",
--
-- 			"-Dspring.datasource.url=jdbc:postgresql://localhost:5432/gep_development",
-- 		},
-- 	},
-- }

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(config)
