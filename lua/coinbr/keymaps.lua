-- there are more keymaps on the plugins folder, inside the plugins config files

vim.g.mapleader = " "

vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end, {desc = "1st Harpoon"})

vim.keymap.set('i', '<S-Tab>', '<C-d>', {noremap = true,          desc = "[insert mode] ↹ Backward tab (unindent)"})
vim.keymap.set('n', '<leader>shift↹', '<S-Tab>', {noremap = true, desc = "[insert mode] ↹ Backward tab (unindent)"})

