return {
  'ThePrimeagen/harpoon', 
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function ()

    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")
    
    vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu, {desc = "Harpoon Menu"})
    vim.keymap.set("n", "<leader>H", mark.add_file, {desc = "Harpoon this"})
    
    vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end, {desc = "1st Harpoon"})
    vim.keymap.set("n", "<C-j>", function() ui.nav_file(2) end, {desc = "2st Harpoon"})
    vim.keymap.set("n", "<C-k>", function() ui.nav_file(3) end, {desc = "3rd Harpoon"})
    vim.keymap.set("n", "<C-l>", function() ui.nav_file(4) end, {desc = "3rd Harpoon"})

    vim.keymap.set("n", "<leader>ctrlh", function() ui.nav_file(1) end, {desc = "1st Harpoon"})
    vim.keymap.set("n", "<leader>ctrlj", function() ui.nav_file(2) end, {desc = "2st Harpoon"})
    vim.keymap.set("n", "<leader>ctrlk", function() ui.nav_file(3) end, {desc = "3rd Harpoon"})
    vim.keymap.set("n", "<leader>ctrll", function() ui.nav_file(4) end, {desc = "3rd Harpoon"})

  end
}
