return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {"nvim-tree/nvim-web-devicons"},
  config = function()

    -- disable netrw
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1


    -- vim left and right to navigate on files and folders
    require("nvim-tree").setup({
      on_attach = function(bufnr)
        local api = require('nvim-tree.api')
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        vim.keymap.set('n', 'l', function()
          api.node.open.edit()
          vim.cmd("normal! j")
          vim.cmd("normal! 0")
          vim.fn.search("\\w", "c")
          vim.cmd("normal! F ")
        end, opts('Open and Move to First Alphanumeric'))

        vim.keymap.set('n', 'h', function()
          api.node.navigate.parent_close()
          vim.cmd("normal! 0")
          vim.fn.search("\\w", "c")
          vim.cmd("normal! F ")
        end, opts('Close and Move to First Alphanumeric'))

        vim.keymap.set('n', 'j', function()
          vim.cmd("normal! j")
          vim.cmd("normal! 0")
          vim.fn.search("\\w", "c")
          vim.cmd("normal! F ")
        end, opts('Move Down and to First Alphanumeric'))

        vim.keymap.set('n', 'k', function()
          vim.cmd("normal! k")
          vim.cmd("normal! 0")
          vim.fn.search("\\w", "c")
          vim.cmd("normal! F ")
        end, opts('Move Up and to First Alphanumeric'))

        -- Add default mappings back
        api.config.mappings.default_on_attach(bufnr)

      end,

      view = {
        width = 35,
        relativenumber = true,
      },

      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },

      },

      -- if multiple windows are present, open file automatically in a specific window without prompting
      actions = {
        open_file = {
          window_picker = {
            enable = false
          }
        }
      },

      -- display git ignored files
      git = {
        ignore = false
      }
    })


    vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", {desc = "Toggle file explorer"})
    vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", {desc = "Focus current file on file explorer"})
    vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", {desc = "Collapse all folders on file explorer"})
    vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", {desc = "Refresh file explorer"})

  end
}

