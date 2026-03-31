vim.g.copilot_filetypes = {
	["*"] = true,
}

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = false
vim.o.swapfile = false

-- vim.o.splitbelow = true
-- vim.o.splitright = true

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true
-- vim.opt.relativenumber = true

vim.opt.showbreak = "+++"

vim.keymap.set("v", "<space>y", '"*y', { silent = true })
vim.keymap.set("n", "<space>p", '"*p', { silent = true })
vim.keymap.set("v", "<space>p", '"*p', { silent = true })

-- what is this?
-- Set completeopt to have a better completion experience
vim.opt.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.opt.termguicolors = true
-- end: what is this?

-- check these
-- Keymaps for better default experience
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
-- trying without this for a bit, to see if it's necessary
-- vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
--vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- --
--   {
--     -- Set lualine as statusline
--     "nvim-lualine/lualine.nvim",
--     -- See `:help lualine.txt`
--     opts = {
--       options = {
--         icons_enabled = false,
--         theme = "onedark",
--         component_separators = "|",
--         section_separators = "",
--       },
--     },
--   },
--
--   {
--     -- Add indentation guides even on blank lines
--     "lukas-reineke/indent-blankline.nvim",
--     -- Enable `lukas-reineke/indent-blankline.nvim`
--     -- See `:help indent_blankline.txt`
--     main = "ibl",
--     opts = {
--       indent = { char = "┊" },
--     },
--   },
--
--   -- "gc" to comment visual regions/lines
--   { "numToStr/Comment.nvim",         opts = {} },
--
--   {
--     -- Highlight, edit, and navigate code
--     "nvim-treesitter/nvim-treesitter",
--     dependencies = {
--       "nvim-treesitter/nvim-treesitter-textobjects",
--     },
--     build = ":TSUpdate",
--   },
--
-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.

-- if vue project, set the vue typescript plugin for the tsserver
-- local is_vue_project = require("lspconfig").util.path.exists("node_modules/@vue") == "directory"
--
-- local servers = {
--   astro = {},
--   gopls = {},
--   eslint = {},
--   volar = {
--     root_dir = lspconfig.util.root_pattern("package.json"),
--     filetypes = { "typescript", "javascript", "vue", "json" },
--   },
--   ts_ls = {
--     root_dir = lspconfig.util.root_pattern("package.json"),
--     single_file_support = true,
--     init_options = {
--       plugins = is_vue_project and {
--         {
--           name = "@vue/typescript-plugin",
--           location = vim.env.FNM_MULTISHELL_PATH .. "/lib/node_modules/@vue/typescript-plugin",
--           languages = { "javascript", "typescript", "vue" },
--         },
--       } or nil,
--     },
--     filetypes = {
--       "javascript",
--       "typescript",
--       "typescriptreact",
--       "vue",
--     },
--   },
--   denols = {
--     root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
--   },
--
--   lua_ls = {
--     settings = {
--       Lua = {
--         workspace = { checkThirdParty = false },
--         telemetry = { enable = false },
--       },
--     },
--   },
--
--   intelephense = {
--     settings = {
--       intelephense = {
--         stubs = {
--           "apache",
--           "bcmath",
--           "bz2",
--           "calendar",
--           "com_dotnet",
--           "Core",
--           "ctype",
--           "curl",
--           "date",
--           "dba",
--           "dom",
--           "enchant",
--           "exif",
--           "FFI",
--           "fileinfo",
--           "filter",
--           "fpm",
--           "ftp",
--           "gd",
--           "gettext",
--           "gmp",
--           "hash",
--           "iconv",
--           "imap",
--           "intl",
--           "json",
--           "ldap",
--           "libxml",
--           "mbstring",
--           "meta",
--           "mysqli",
--           "oci8",
--           "odbc",
--           "openssl",
--           "pcntl",
--           "pcre",
--           "PDO",
--           "pdo_ibm",
--           "pdo_mysql",
--           "pdo_pgsql",
--           "pdo_sqlite",
--           "pgsql",
--           "Phar",
--           "posix",
--           "pspell",
--           "readline",
--           "Reflection",
--           "session",
--           "shmop",
--           "SimpleXML",
--           "snmp",
--           "soap",
--           "sockets",
--           "sodium",
--           "SPL",
--           "sqlite3",
--           "standard",
--           "superglobals",
--           "sysvmsg",
--           "sysvsem",
--           "sysvshm",
--           "tidy",
--           "tokenizer",
--           "xml",
--           "xmlreader",
--           "xmlrpc",
--           "xmlwriter",
--           "xsl",
--           "Zend OPcache",
--           "zip",
--           "zlib",
--           "wordpress"
--         }
--       }
--     }
--   }
-- }
