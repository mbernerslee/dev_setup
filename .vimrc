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

" Install plugins with Plug
" elm-vim MUST BE before vim-polyglot because of a bug
" https://github.com/ElmCast/elm-vim/issues/133#issuecomment-333317387
call plug#begin('~/.vim/plugged')
  Plug 'altercation/vim-colors-solarized'
  Plug 'Hermanverschooten/elm-vim', { 'branch' : 'run_format_in_elm_root' }
  Plug 'sheerun/vim-polyglot'
  Plug 'slashmili/alchemist.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'mhinz/vim-mix-format'
  Plug 'elmcast/elm-vim'
call plug#end()

"disable polyglot for elm only
let g:polyglot_disabled = ['elm']

" fzf fuzzy finder configuration
noremap <C-p> :Files<cr>
let $FZF_DEFAULT_COMMAND = 'ack -g ""'

"Colour scheme
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized

command! -nargs=1 Silent
      \   execute 'silent !' . <q-args>
      \ | execute 'redraw!'

autocmd BufWritePost *.elm :Silent ~/src/platform/assets/node_modules/elm-format/bin/elm-format <afile> --elm-version=0.19 --yes
