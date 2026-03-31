-- Highlight, edit, and navigate code

vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

-- lazy = false,
-- build = ":TSUpdate",
-- branch = "main",

-- [[ Configure Treesitter ]] See `:help nvim-treesitter-intro`
local parsers = {
	"bash",
	"c",
	"diff",
	"html",
	"css",
	"kotlin",
	"java",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"query",
	"vim",
	"vimdoc",
	"typescript",
	"javascript",
	"astro",
	"vue",
}

require("nvim-treesitter").install(parsers)

-- Automatically update parsers when nvim-treesitter is updated
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

-- [[ Enable Treesitter-based features ]]
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local buf, filetype = args.buf, args.match

		local language = vim.treesitter.language.get_lang(filetype)
		if not language then
			return
		end

		-- check if parser exists and load it
		if not vim.treesitter.language.add(language) then
			return
		end
		-- enables syntax highlighting and other treesitter features
		vim.treesitter.start(buf, language)

		-- enables treesitter based folds
		-- for more info on folds see `:help folds`
		-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		-- vim.wo.foldmethod = 'expr'

		-- enables treesitter based indentation
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
