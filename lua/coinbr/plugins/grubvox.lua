return {
  'ellisonleao/gruvbox.nvim',
  config = function()

    require("gruvbox").setup({
      contrast = "hard",
      palette_overrides = {
        bg0 = "#000000",  
      },
      overrides = {
        Normal = { bg = "#000000" },  
      }
    })

    vim.cmd("colorscheme gruvbox")
  end
}

