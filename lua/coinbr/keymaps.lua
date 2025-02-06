-- there are more keymaps on the plugins folder, inside the plugins config files

vim.g.mapleader = " "

local function enter_normal_mode_and_clear_search_highlights()
    vim.cmd('nohlsearch')
    vim.cmd('stopinsert')
end

vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end, {desc = "1st Harpoon"})

vim.keymap.set('i', '<S-Tab>', '<C-d>', {noremap = true,          desc = "[insert mode] ↹ Backward tab (unindent)"})
vim.keymap.set('n', '<leader>shift↹', '<S-Tab>', {noremap = true, desc = "[insert mode] ↹ Backward tab (unindent)"})

vim.keymap.set({'i', 'n', 'v'}, '<Esc>', enter_normal_mode_and_clear_search_highlights, {noremap = true, silent = true, desc = "Enter normal mode and clear search highlights"})
vim.keymap.set({'i', 'n', 'v'}, '<C-[>', enter_normal_mode_and_clear_search_highlights, {noremap = true, silent = true, desc = "Enter normal mode and clear search highlights"})
