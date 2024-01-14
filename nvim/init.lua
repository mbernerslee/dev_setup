-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)


-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require("vim-options")
require('lazy').setup("plugins")
--  {
--    -- Autocompletion
--    'hrsh7th/nvim-cmp',
--    dependencies = {
--      -- Snippet Engine & its associated nvim-cmp source
--      'L3MON4D3/LuaSnip',
--      'saadparwaiz1/cmp_luasnip',
--
--      -- Adds LSP completion capabilities
--      'hrsh7th/cmp-nvim-lsp',
--      'hrsh7th/cmp-path',
--
--      -- Adds a number of user-friendly snippets
--      'rafamadriz/friendly-snippets',
--    },
--  },
--  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
--  --       These are some example plugins that I've included in the kickstart repository.
--  --       Uncomment any of the lines below to enable them.
--  -- require 'kickstart.plugins.autoformat',
--  -- require 'kickstart.plugins.debug',
--
--  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
--  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
--  --    up-to-date with whatever is in the kickstart repo.
--  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
--  --
--  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
--  -- { import = 'custom.plugins' },
--
--  --'https://github.com/rafi/awesome-vim-colorschemes',
--}, {})

--
---- nvim-cmp supports additional completion capabilities, so broadcast that to servers
--local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--
---- Ensure the servers above are installed
--local mason_lspconfig = require 'mason-lspconfig'
--
--mason_lspconfig.setup {
--  ensure_installed = vim.tbl_keys(servers),
--}
--
--mason_lspconfig.setup_handlers {
--  function(server_name)
--    require('lspconfig')[server_name].setup {
--      capabilities = capabilities,
--      on_attach = on_attach,
--      settings = servers[server_name],
--      filetypes = (servers[server_name] or {}).filetypes,
--    }
--  end,
--}
--
---- [[ Configure nvim-cmp ]]
---- See `:help cmp`
----local cmp = require 'cmp'
----local luasnip = require 'luasnip'
----require('luasnip.loaders.from_vscode').lazy_load()
----luasnip.config.setup {}
----
----cmp.setup {
----  snippet = {
----    expand = function(args)
----      luasnip.lsp_expand(args.body)
----    end,
----  },
----  completion = {
----    completeopt = 'menu,menuone,noinsert',
----  },
----  mapping = cmp.mapping.preset.insert {
----    ['<C-n>'] = cmp.mapping.select_next_item(),
----    ['<C-p>'] = cmp.mapping.select_prev_item(),
----    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
----    ['<C-f>'] = cmp.mapping.scroll_docs(4),
----    ['<C-Space>'] = cmp.mapping.complete {},
----    ['<CR>'] = cmp.mapping.confirm {
----      behavior = cmp.ConfirmBehavior.Replace,
----      select = true,
----    },
----    ['<Tab>'] = cmp.mapping(function(fallback)
----      if cmp.visible() then
----        cmp.select_next_item()
----      elseif luasnip.expand_or_locally_jumpable() then
----        luasnip.expand_or_jump()
----      else
----        fallback()
----      end
----    end, { 'i', 's' }),
----    ['<S-Tab>'] = cmp.mapping(function(fallback)
----      if cmp.visible() then
----        cmp.select_prev_item()
----      elseif luasnip.locally_jumpable(-1) then
----        luasnip.jump(-1)
----      else
----        fallback()
----      end
----    end, { 'i', 's' }),
----  },
----  sources = {
----    { name = 'nvim_lsp' },
----    { name = 'luasnip' },
----    { name = 'path' },
----  },
----}
--
---- autoformat files on save
--vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
-- the other reccommended way to do it
--vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
