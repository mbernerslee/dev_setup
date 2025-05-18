-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

vim.o.swapfile = false
vim.api.nvim_set_keymap("i", "jj", "<ESC>", { noremap = true, silent = true })

--vim.o.tapstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.api.nvim_set_keymap("n", "<CR>", ":noh<CR>", {})
vim.o.number = true
vim.o.relativenumber = true
vim.o.ruler = true
vim.o.hlsearch = true
--vim.o.nocompatible = true
vim.o.autoread = true
vim.o.autoindent = true
--vim.o.termguicolours = true
vim.opt.completeopt = { "menu" }
--vim.o.background = 'dark'

-- Enable clipboard
--vim.opt.clipboard = 'unnamedplus'
--vim.opt.clipboard = 'unnamed'

-- clipboard pain on windows solved by this & installing xclip
-- https://rlc.vlinder.ca/blog/2016/04/setting-up-cygwin-for-x-forwarding/

--in normal mode map <leader>d to delete without wrecking the regular 'yank' "buffer (and so on)
vim.api.nvim_set_keymap("n", "<leader>d", "_d", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>p", "_dP", { noremap = true })
--vim.api.nvim_set_keymap("i", "<C-P>", "<C-X><C-O>", { noremap = true })

--don't jump to the next search when you hit *, stay where you are
vim.api.nvim_set_keymap("n", "*", "*``", { noremap = true })

-- set cp to copy the current file path to the main OS clipboard
vim.keymap.set('n', 'cp', function()
  local current_file = vim.fn.expand('%')
  vim.fn.setreg('+', current_file)
  print("Copied: " .. current_file)
end, { noremap = true, silent = true, desc = "Copy current file path" })

--Remove whitespace at the end ofthe line
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[:%s/\s\+$//e]]
})

-- Run mix format on file save
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.{ex,exs}", -- Elixir source and script files
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.fn.jobstart({ 'mix', 'format', vim.api.nvim_buf_get_name(bufnr) }, {
      on_exit = function(_, code)
        if code == 0 then
          vim.api.nvim_buf_call(bufnr, function()
            vim.cmd('silent! edit!')
          end)
        end
      end
    })
  end
})
