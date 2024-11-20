return {
   "tpope/vim-projectionist",
   config = function()
     vim.g.projectionist_heuristics = {
        ["*"] = {
          ["test/*_test.exs"] = {
            alternate = "lib/{}.ex",
          },
          ["lib/*.ex"] = {
            alternate = "test/{}_test.exs",
          }
        },
     }

    -- this doesn't work
    --vim.api.nvim_set_keymap('n', '<Leader>A', '<cmd>A<CR>', { noremap = true, silent = true })
   end,
 }
