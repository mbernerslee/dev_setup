" General stuff
inoremap jj <ESC>
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2
map <CR> :noh<CR>
set number
set ruler
set hlsearch
set nocompatible
set autoread

"Remove whitespace at the end ofthe line
autocmd BufWritePre * :%s/\s\+$//e

"Run mix format for elixir files on save
let g:mix_format_on_save = 1
let g:mix_format_silent_errors = 1

" Automatically instal Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install plugins with Plug
call plug#begin('~/.vim/plugged')
  Plug 'altercation/vim-colors-solarized'
  Plug 'sheerun/vim-polyglot'
  Plug 'slashmili/alchemist.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'mhinz/vim-mix-format'
call plug#end()

" fzf fuzzy finder configuration
noremap <C-p> :Files<cr>
let $FZF_DEFAULT_COMMAND = 'ack -g ""'

"Colour scheme
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized

