require('virt-column').setup({ char = '|' })
vim.cmd [[
  autocmd FileType gitcommit setlocal colorcolumn=50
]]

