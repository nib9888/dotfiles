" Plug
call plug#begin()

Plug 'ap/vim-css-color'
Plug 'dylanaraps/wal.vim'
Plug 'vim-scripts/indentpython.vim'
Plug 'nvie/vim-flake8'
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/indentLine'
Plug 'sheerun/vim-polyglot'
Plug 'vim-syntastic/syntastic'
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'mbbill/undotree'
Plug 'morhetz/gruvbox'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-commentary'

call plug#end()


" Various Settings
filetype off
filetype plugin indent on
syntax on
set hidden
set nocompatible
set number
set relativenumber
set undofile
let python_highlight_all=1
set encoding=utf-8

" Indenting
set expandtab
set tabstop=8
set shiftwidth=4
set autoindent
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" Autocommands
autocmd FileType python setlocal colorcolumn=80
autocmd FileType c,cpp setlocal colorcolumn=80 shiftwidth=8 expandtab
autocmd FileType html,css setlocal shiftwidth=2
autocmd BufNewFile,BufRead /*.rasi setf css


" Status bar
set laststatus=2
set noshowmode
function! LightlineReadonly()
  return &readonly && &filetype !=# 'help' ? 'RO' : ''
endfunction
let g:lightline = {
  \ 'colorscheme': 'gruvbox',
  \ 'active': {
  \   'left': [ [ 'mode' ],
  \              [ 'readonly', 'filename', 'modified' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'fileformat', 'filetype' ] ]
  \ },
  \ 'component_function': {
  \   'readonly': 'LightlineReadonly'
  \ },
  \ }

" Colourscheme
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set bg=dark
let g:gruvbox_italic = '1'
let g:gruvbox_undercurl = '1'
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_sign_column = 'bg0'
let g:gruvbox_improved_warnings = '1'
let g:gruvbox_italicize_strings = '1'
colorscheme gruvbox
highlight Normal guibg=NONE ctermbg=NONE

" File Explorer
let g:netrw_banner=0

" Keybindings
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <tab> <C-w>
noremap <tab><tab> <C-w><C-w>

" Have `cw` adhere to its actual movement `w`, instead of duplicating `ce`.
nnoremap cw dwi
nnoremap cW dWi

" Linting
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
