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
        SignColumn = { bg = "#000000" },  -- Make sign column background black

      }
    })

    vim.cmd("colorscheme gruvbox")
    vim.opt.termguicolors = true
    vim.opt.background = "dark"
  end
}

