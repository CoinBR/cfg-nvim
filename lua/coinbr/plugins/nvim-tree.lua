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


    vim.keymap.set("n", "<leader>eh", "<cmd>NvimTreeToggle<CR>", {desc = "Toggle file explorer"})
    vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", {desc = "Focus current file on file explorer"})
    vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", {desc = "Collapse all folders on file explorer"})
    vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", {desc = "Refresh file explorer"})

    vim.keymap.set('n', '<leader>ee', function()
      local nvim_tree_wins = {}
      local current_win = vim.api.nvim_get_current_win()
      local all_wins = vim.api.nvim_list_wins()
      local current_buf = vim.api.nvim_get_current_buf()

      for _, w in pairs(all_wins) do
        local buf = vim.api.nvim_win_get_buf(w)
        local buf_name = vim.api.nvim_buf_get_name(buf)
        if buf_name:match("NvimTree_") then
          table.insert(nvim_tree_wins, w)
        end
      end

      if #nvim_tree_wins > 0 then
        if vim.bo[current_buf].filetype == "NvimTree" then
          -- We're in NvimTree, so find a non-NvimTree window to focus
          for _, w in pairs(all_wins) do
            if w ~= current_win then
              local buf = vim.api.nvim_win_get_buf(w)
              if vim.bo[buf].filetype ~= "NvimTree" then
                vim.api.nvim_set_current_win(w)
                return
              end
            end
          end
        else
          -- We're not in NvimTree, so focus the NvimTree window
          vim.api.nvim_set_current_win(nvim_tree_wins[1])
        end
      else
        vim.cmd("NvimTreeToggle")
      end
    end, {desc = "Switch focus between file and explorer"})


  end
}

