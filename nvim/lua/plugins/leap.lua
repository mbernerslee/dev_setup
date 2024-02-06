return {
  "https://github.com/ggandor/leap.nvim.git",
  dependencies = {
    "git@github.com:tpope/vim-repeat.git",
  },
  config = function()
    require("leap").create_default_mappings()
  end,
}
