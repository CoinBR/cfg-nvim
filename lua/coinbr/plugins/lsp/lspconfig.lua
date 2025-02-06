return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap 

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        keymap.set("n", "<Tab>", function()
            local cursor_pos = vim.api.nvim_win_get_cursor(0)
            local line = cursor_pos[1] - 1
            local col = cursor_pos[2]

            -- First check for diagnostics (errors/warnings)
            local diagnostics = vim.diagnostic.get(0, { lnum = line })
            if #diagnostics > 0 then
                vim.lsp.buf.code_action()
                return
            end

            -- Get word under cursor
            local word = vim.fn.expand('<cword>')
            if word == '' then
                -- Fallback to normal tab if no word under cursor
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
                return
            end

            -- Check if we're on a type/interface
            local symbol_info = vim.lsp.buf_request_sync(0, 'textDocument/hover', vim.lsp.util.make_position_params(), 1000)
            if symbol_info then
                local hover_text = symbol_info[1] and symbol_info[1].result and symbol_info[1].result.contents.value or ""
                
                if hover_text:match("interface") or hover_text:match("class") then
                    -- If it's an interface/class, show implementations
                    vim.cmd('Telescope lsp_implementations')
                    return
                end
            end

            -- Check for multiple definitions
            local defs = vim.lsp.buf_request_sync(0, 'textDocument/definition', vim.lsp.util.make_position_params(), 1000)
            if defs and defs[1] and defs[1].result and #defs[1].result > 1 then
                -- If multiple definitions exist, show them all
                vim.cmd('Telescope lsp_definitions')
                return
            end

            -- Check for references
            local refs = vim.lsp.buf_request_sync(0, 'textDocument/references', vim.lsp.util.make_position_params(), 1000)
            if refs and refs[1] and refs[1].result and #refs[1].result > 1 then
                -- If multiple references exist, show them
                vim.cmd('Telescope lsp_references')
                return
            end

            -- If we get here, just go to definition as default action
            vim.cmd('Telescope lsp_definitions')
        end, {
            desc = "Smart LSP navigation"
        })

        keymap.set("n", "<S-Tab>", function()
            local cursor_pos = vim.api.nvim_win_get_cursor(0)
            local line = cursor_pos[1] - 1
            local col = cursor_pos[2]

            -- Get word under cursor
            local word = vim.fn.expand('<cword>')
            if word == '' then
                -- Fallback to normal shift-tab if no word under cursor
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", false)
                return
            end

            vim.cmd('Telescope lsp_type_definitions')
        end, {
            desc = "Show type definitions"
        })



        opts.desc = "Smart rename"
        keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)

        opts.desc = "Show diagnostics for file"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) 

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    mason_lspconfig.setup_handlers({
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["svelte"] = function()
        -- configure svelte server
        lspconfig["svelte"].setup({
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePost", {
              pattern = { "*.js", "*.ts" },
              callback = function(ctx)
                -- Here use ctx.match instead of ctx.file
                client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
              end,
            })
          end,
        })
      end,
      ["graphql"] = function()
        -- configure graphql language server
        lspconfig["graphql"].setup({
          capabilities = capabilities,
          filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
        })
      end,
      ["emmet_ls"] = function()
        -- configure emmet language server
        lspconfig["emmet_ls"].setup({
          capabilities = capabilities,
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
        })
      end,
      ["lua_ls"] = function()
        -- configure lua server (with special settings)
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              -- make the language server recognize "vim" global
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
    })
  end,
}
