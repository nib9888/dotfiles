" Plugins
call plug#begin()

Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'lifepillar/vim-gruvbox8'
Plug 'famiu/feline.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'liuchengxu/vim-clap', { 'do': { -> clap#installer#force_download() } }
Plug 'vn-ki/coc-clap'

call plug#end()

" Various Settings
filetype indent on
filetype plugin on
syntax on

set nocompatible
set hidden
set updatetime=300
set shortmess+=c
set signcolumn=yes
set lazyredraw
set backspace=eol,start,indent
set noerrorbells
set novisualbell

set showmatch
set smartcase
set hlsearch
set incsearch

set tabstop=4
set softtabstop=4
set shiftwidth=4
autocmd FileType html setlocal shiftwidth=2
set expandtab
set autoindent

set number
autocmd FileType python set cc=80
set wildmode=longest,list
set relativenumber
set termguicolors
let g:gruvbox_transp_bg = 1
colorscheme gruvbox8
"set foldmethod=expr
"set foldexpr=nvim_treesitter#foldexpr()

" Plugin Settings
lua <<EOF
    local components = {
      active = {},
      inactive = {},
    }

    table.insert(components.active, {})
    table.insert(components.active, {})
    table.insert(components.active, {})
    table.insert(components.inactive, {})
    table.insert(components.inactive, {})
    table.insert(components.active[1], {
        provider = 'position'
    })
    table.insert(components.active[3], {
        provider = 'git_branch'
    })
    local properties = {
        force_inactive = {
            filetypes = {
                'NvimTree',
                'dbui',
                'packer',
                'fugitive',
                'fugitiveblame'
            },
            buftypes = {'terminal'},
            bufnames = {}
        }
    }
    require('feline').setup {
        --components = components,
        properties = properties
    }
EOF
lua << EOF
require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitGutterAdd'   , text = '│', numhl='GitSignsAddNr'},
    change       = {hl = 'GitGutterChange', text = '│', numhl='GitSignsChangeNr'},
    delete       = {hl = 'GitGutterDelete', text = '_', numhl='GitSignsDeleteNr'},
    topdelete    = {hl = 'GitGutterDelete', text = '‾', numhl='GitSignsDeleteNr'},
    changedelete = {hl = 'GitGutterChange', text = '~', numhl='GitSignsChangeNr'},
  },
  word_diff = true
}
EOF
lua <<EOF
    require("indent_blankline").setup { char = "|", buftype_exclude = {"terminal"} }
EOF
lua <<EOF
    require('nvim-treesitter.configs').setup {
        ensure_installed = "maintained",
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = true,
        },
    }
EOF

" Keybinds
let g:mapleader=" "
" Have `cw` adhere to its actual movement `w`, instead of duplicating `ce`.
nnoremap cw dwi
nnoremap cW dWi
map Y y$

" Stay in visual mode after indenting
vnoremap > >gv
vnoremap < <gv

" QoL
nnoremap <silent> Q :q<cr>
nnoremap <silent> <C-[> :nohl<CR>
nnoremap <C-o> <C-w>

" Clap keybinds
nnoremap <silent> <leader>ff :Clap gfiles<CR>
nnoremap <silent> <leader>fF :Clap files<CR>
nnoremap <silent> <leader>fb :Clap buffers<CR>
nnoremap <silent> <leader>fo :Clap coc_outline<CR>
nnoremap <silent> <leader>fl :Clap blines<CR>
nnoremap <silent> <leader>fL :Clap lines<CR>
nnoremap <silent> <leader>fd :Clap coc_diagnostics<CR>

" CoC keybinds
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nnoremap <leader>cr <Plug>(coc-rename)
nnoremap <silent> <leader>ca :CocAction<CR>
nmap <leader>cf <Plug>(coc-format-selected)
vmap <leader>cf <Plug>(coc-format-selected)
autocmd CursorHold * silent call CocActionAsync('highlight')
