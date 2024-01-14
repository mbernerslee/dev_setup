return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin"
    end
  }
}


--  -------------
--  -- Colorscheme graveyard
--  -------------
--
--  --{
--  --  -- Theme inspired by Atom
--  --  'navarasu/onedark.nvim',
--  --  priority = 1000,
--  --  config = function()
--  --    vim.cmd.colorscheme 'onedark'
--  --  end,
--  --},
--
--  {
--    "ellisonleao/gruvbox.nvim",
--    priority = 1000,
--    config = function()
--      vim.cmd.colorscheme 'gruvbox'
--    end,
--  },
--
--  --{
--  --  "mhartington/oceanic-next",
--  --  priority = 1000,
--  --  config = function()
--  --    vim.cmd.colorscheme 'OceanicNext'
--  --  end,
--  --},
--
--  --{
--  --  "Th3Whit3Wolf/one-nvim",
--  --  priority = 1000,
--  --  config = function()
--  --    vim.cmd.colorscheme 'one-nvim'
--  --  end,
--  --},
--
--  --{
--  --  "EdenEast/nightfox.nvim",
--  --  priority = 1000,
--  --  config = function()
--  --    vim.cmd.colorscheme 'nordfox'
--  --  end,
--  --},
