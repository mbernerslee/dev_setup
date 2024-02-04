return {
  "https://github.com/ggandor/leap.nvim.git",
  dependencies = {
    "repeat.vim",
  },
  config = function()
    require("leap").create_default_mappings()
  end,
}
