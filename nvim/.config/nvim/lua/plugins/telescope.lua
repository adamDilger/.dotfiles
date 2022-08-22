vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files);
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep);
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers);
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags);
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics);
