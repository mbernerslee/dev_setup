return {
  "https://github.com/ggandor/leap.nvim.git",
  dependencies = {
    --"git@github.com:tpope/vim-repeat.git",
    "https://github.com/tpope/vim-repeat.git"
  },
  config = function()
    require("leap").create_default_mappings()

    vim.keymap.set('n', 's', function()
      local focusable_windows = vim.tbl_filter(
        function(win) return vim.api.nvim_win_get_config(win).focusable end,
        vim.api.nvim_tabpage_list_wins(0)
      )
      require('leap').leap { target_windows = focusable_windows }
    end)
  end,
}
