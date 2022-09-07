local null_ls = require("null-ls")

local sources = {
	null_ls.builtins.formatting.goimports,
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.formatting.prettierd,
}

if not _PROJECT.NULL_LS_SKIP_ESLINT then
	table.insert(sources, null_ls.builtins.diagnostics.eslint_d)
end

null_ls.setup({ sources = sources })
