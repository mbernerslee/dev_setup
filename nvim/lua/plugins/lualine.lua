--  See `:help lualine.txt`
return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = false,
        theme = "catppuccin",
        component_separators = '|',
        section_separators = '',
      },
    })
  end,
}
