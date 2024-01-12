-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  --{
  --  -- LSP Configuration & Plugins
  --  'neovim/nvim-lspconfig',
  --  dependencies = {
  --    -- Automatically install LSPs to stdpath for neovim
  --    { 'williamboman/mason.nvim', config = true },
  --    'williamboman/mason-lspconfig.nvim',

  --    -- Useful status updates for LSP
  --    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
  --    { 'j-hui/fidget.nvim', opts = {} },

  --    -- Additional lua configuration, makes nvim stuff amazing!
  --    'folke/neodev.nvim',
  --  },
  --},

  --{
  --  -- Autocompletion
  --  'hrsh7th/nvim-cmp',
  --  dependencies = {
  --    -- Snippet Engine & its associated nvim-cmp source
  --    'L3MON4D3/LuaSnip',
  --    'saadparwaiz1/cmp_luasnip',

  --    -- Adds LSP completion capabilities
  --    'hrsh7th/cmp-nvim-lsp',
  --    'hrsh7th/cmp-path',

  --    -- Adds a number of user-friendly snippets
  --    'rafamadriz/friendly-snippets',
  --  },
  --},

  -- Useful plugin to show you pending keybinds.
  --{ 'folke/which-key.nvim', opts = {} },

 -- {
 --   -- Theme inspired by Atom
 --   'navarasu/onedark.nvim',
 --   priority = 1000,
 --   config = function()
 --     vim.cmd.colorscheme 'onedark'
 --   end,
 -- },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  --{
  --  -- Add indentation guides even on blank lines
  --  'lukas-reineke/indent-blankline.nvim',
  --  -- Enable `lukas-reineke/indent-blankline.nvim`
  --  -- See `:help ibl`
  --  main = 'ibl',
  --  opts = {},
  --},

  -- "gc" to comment visual regions/lines
  --{ 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  --{
  --  -- Highlight, edit, and navigate code
  --  'nvim-treesitter/nvim-treesitter',
  --  dependencies = {
  --    'nvim-treesitter/nvim-treesitter-textobjects',
  --  },
  --  build = ':TSUpdate',
  --},

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'custom.plugins' },

  --'shaunsingh/solarized.nvim'
  'https://github.com/rafi/awesome-vim-colorschemes',
  'sheerun/vim-polyglot'


}, {})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

vim.o.swapfile = false
vim.api.nvim_set_keymap("i", "jj", "<ESC>", { noremap = true, silent = true })
vim.o.tapstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.api.nvim_set_keymap("n", "<CR>", ":noh<CR>", {})
vim.o.number = true
vim.o.relativenumber = true
vim.o.ruler = true
vim.o.hlsearch = true
vim.o.nocompatible = true
vim.o.autoread = true
vim.o.autoindent = true

--"in normal mode map <leader>d to delete without wrecking the regular 'yank' "buffer (and so on)
vim.api.nvim_set_keymap("n", "<leader>d", "_d", { noremap = true})
vim.api.nvim_set_keymap("n", "<leader>p", "_dP", { noremap = true})

--"don't jump to the next search when you hit *, stay where you are
vim.api.nvim_set_keymap("n", "*", "*``", { noremap = true})

--"Remove whitespace at the end ofthe line
vim.api.nvim_create_autocmd( {"BufWritePre"}, {
  pattern = { "*" },
  command = [[:%s/\s\+$//e]]
})

--vim.cmd.colorscheme 'onedark'
vim.cmd.colorscheme 'solarized8_flat'
--require('solarized').set()

-- Telescope mappings
--vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
--vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

