return {
  "https://github.com/github/copilot.vim",
  config = function()
    --require("leap").create_default_mappings()

    --vim.keymap.set('n', 's', function()
    --  local focusable_windows = vim.tbl_filter(
    --    function(win) return vim.api.nvim_win_get_config(win).focusable end,
    --    vim.api.nvim_tabpage_list_wins(0)
    --  )
    --  require('leap').leap { target_windows = focusable_windows }
    --end)
  end,
}

