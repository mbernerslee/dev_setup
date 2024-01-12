" see https://www.youtube.com/watch?v=JWReY93Vl6g
"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath = &runtimepath
"source ~/.vimrc

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

call plug#begin()

Plug 'https://github.com/rafi/awesome-vim-colorschemes'
Plug 'vim-airline/vim-airline' "for the swanky looking bar at the bottom
Plug 'sheerun/vim-polyglot' "syntax highlighting for many many languages
Plug 'rust-lang/rust.vim'
Plug 'dense-analysis/ale'
"telescope
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
Plug 'nvim-lua/plenary.nvim' "dependency of telescope
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} "recommended by telescope
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' } "reccomended by telescope

call plug#end()

" Telescope keybindings
nnoremap <C-p> <cmd>Telescope find_files<cr>
"[S]earch [S]elect Telescope
nnoremap <leader>ss <cmd>Telescope builtin<cr>
"Search [G]it [F]iles
nnoremap <leader>gf <cmd>Telescope git_files<cr>
"[S]earch [F]iles
nnoremap <leader>sf <cmd>Telescope find_files<cr>
"[S]earch [H]elp
nnoremap <leader>sh <cmd>Telescope help_tags<cr>
"[S]earch current [W]ord
nnoremap <leader>sw <cmd>Telescope grep_string<cr>
"[S]earch by [G]rep
nnoremap <leader>sg <cmd>Telescope live_grep<cr>
"[S]earch [D]iagnostics
nnoremap <leader>sd <cmd>Telescope diagnostics<cr>
"[S]earch [R]esume
nnoremap <leader>sr <cmd>Telescope resume<cr>


"NOPE telescope stuff that requires plugs I don't have right now
"vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
"vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })

command FormatJson %!jq .

" Rust autoformat on save
let g:rustfmt_autosave = 1

"awesome-vim-colorschemes
:colorscheme solarized8_flat
":colorscheme mountaineer

" air-line
"let g:airline_powerline_fonts = 1

command! -nargs=1 Silent
      \   execute 'silent !' . <q-args>
      \ | execute 'redraw!'

autocmd BufWritePost *.elm :Silent ~/src/platform/assets/node_modules/elm-format/bin/elm-format <afile> --elm-version=0.19 --yes

"for turning on spellcheck
"set spell spelllang=en_gb

"dence-analysis/ale
let g:ale_fixers = { 'elixir': ['mix_format'], '*.html.heex': ['mix_format'] }
let g:ale_fix_on_save = 1
