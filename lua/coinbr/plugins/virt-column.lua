return {
  'lukas-reineke/virt-column.nvim',

  config = function()

    require('virt-column').setup({ char = '|' })
    vim.cmd [[ autocmd FileType gitcommit setlocal colorcolumn=50 ]]

  end
}


