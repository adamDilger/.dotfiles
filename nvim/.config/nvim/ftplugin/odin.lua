vim.opt_local.makeprg = "odin build ."

-- Matches Odin compiler output: file.odin(5:12) Error: msg or similar patterns
vim.opt_local.errorformat = "%f(%l:%c) %t%*[^:]: %m,%-G%.%#"
