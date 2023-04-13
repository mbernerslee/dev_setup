" General stuff
set noswapfile
inoremap jj <ESC>
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2
map <CR> :noh<CR>
set number
"set relative line numbers (or rather 'hybrid' since it has the current asbolute line number
set relativenumber
set ruler
set hlsearch
set nocompatible
set autoread
"newline indetation problem fixer https://stackoverflow.com/questions/30408178/indenting-after-newline-following-new-indent-level-vim
set autoindent
let mapleader = "\<Space>"
"in normal mode map <leader>d to delete without wrecking the regular 'yank' "buffer (and so on)
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP

"don't jump to the next search when you hit *, stay where you are
nnoremap * *``

"Remove whitespace at the end ofthe line
autocmd BufWritePre * :%s/\s\+$//e

"disable polyglot for elm only
let g:polyglot_disabled = ['elm']

call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'dense-analysis/ale'
call plug#end()

" fzf fuzzy finder configuration
noremap <C-p> :Files<cr>
let $FZF_DEFAULT_COMMAND = 'ack -g ""'

command FormatJson %!jq .

" Rust autoformat on save
let g:rustfmt_autosave = 1

"Colour scheme
syntax on
set t_Co=256
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

command! -nargs=1 Silent
      \   execute 'silent !' . <q-args>
      \ | execute 'redraw!'

autocmd BufWritePost *.elm :Silent ~/src/platform/assets/node_modules/elm-format/bin/elm-format <afile> --elm-version=0.19 --yes

"dence-analysis/ale
let g:ale_fixers = { 'elixir': ['mix_format'], '*.html.heex': ['mix_format'] }
let g:ale_fix_on_save = 1
