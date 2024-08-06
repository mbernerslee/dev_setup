return {
  "https://github.com/pasky/claude.vim.git",
  config = function()
    local claude_api_key = os.getenv("ANTHROPIC_API_KEY")
    vim.g.claude_api_key = claude_api_key
  end,
}
