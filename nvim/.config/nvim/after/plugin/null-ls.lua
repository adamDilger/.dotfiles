local null_ls = require("null-ls")

local sources = {
	null_ls.builtins.formatting.goimports,
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.formatting.rustfmt,
}

if _PROJECT.PRETTIER then
	table.insert(sources, null_ls.builtins.formatting.prettierd)
end

if _PROJECT.ES_LINT then
	table.insert(sources, null_ls.builtins.diagnostics.eslint_d)
end

null_ls.setup({ sources = sources })
