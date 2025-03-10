return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      local mason_lspconfig = require 'mason-lspconfig'
      local servers = {
        rust_analyzer = {},
        elixirls = {
          settings = {
            dialyzer_enabled = false
          }
        },

        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
      }
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      --capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')
        -- Autoformat files on save
        --vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
        --the other reccommended way to do it
        --
        --async=true in an attempt to not freeze neovim when formatting elixir files fails because it can't compile the code
        --vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format({async=true})]]
        --
        --------------------------------------------------------------------------------------------
        -- The most recently commented out version! (since the lsp is failing so hard right now!) -
        -- Am using a version of this in the main vim-options.lua config instead
        --------------------------------------------------------------------------------------------
        -- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
        --------------------------------------------------------------------------------------------

        -- Create a command `:Format` local to the LSP buffer
        --vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        --  vim.lsp.buf.format()
        --end, { desc = 'Format current buffer with LSP' })
      end

      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers)
      }
      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end,
      }
    end,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      -- Autoformat files on save
      --vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
      --the other reccommended way to do it
      --vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
    end,
  },
}
