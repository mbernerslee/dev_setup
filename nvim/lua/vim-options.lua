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
vim.o.termguicolours = true
vim.opt.completeopt = { "menu" }
--vim.o.background = 'dark'

--in normal mode map <leader>d to delete without wrecking the regular 'yank' "buffer (and so on)
vim.api.nvim_set_keymap("n", "<leader>d", "_d", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>p", "_dP", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-P>", "<C-X><C-O>", { noremap = true })

--don't jump to the next search when you hit *, stay where you are
vim.api.nvim_set_keymap("n", "*", "*``", { noremap = true })

--Remove whitespace at the end ofthe line
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[:%s/\s\+$//e]]
})
