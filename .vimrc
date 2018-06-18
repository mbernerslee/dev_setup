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

"Remove whitespace at the end ofthe line
autocmd BufWritePre * :%s/\s\+$//e

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
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
call plug#end()

" fzf fuzzy finder configuration
noremap <C-p> :Files<cr>

"Colour scheme
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized
