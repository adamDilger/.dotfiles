-- General
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.linebreak = true
vim.opt.showbreak = "+++"
vim.opt.textwidth = 0
vim.opt.showmatch = true
vim.opt.visualbell = true

vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.hlsearch = false

vim.opt.autoindent = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Advanced
vim.opt.ruler = true
vim.opt.swapfile = false

vim.opt.undolevels = 1000
vim.opt.backspace = "indent,eol,start"
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.list = true
vim.opt.listchars = "tab:>-"
vim.opt.signcolumn = "yes"

vim.g.mapleader = " "

vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>P", '"+P')
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')

vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")

require("gruvbox").setup({
  contrast = "hard"
})

vim.cmd([[colorscheme gruvbox]])

-- folding? haven't figured this out yet
-- vim.opt.foldlevel = 20
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
