" General
set number             " Show line numbers
set linebreak          " Break lines at word (requires Wrap lines)
set showbreak=+++      " Wrap-broken line prefix
set textwidth=100      " Line wrap (number of cols)
set showmatch          " Highlight matching brace
set visualbell         " Use visual bell (no beeping)

set smartcase          " Enable smart-case search
set ignorecase         " Always case-insensitive
set incsearch          " Searches for strings incrementally

set autoindent         " Auto-indent new lines
set shiftwidth=2       " Number of auto-indent spaces
set smartindent        " Enable smart-indent
set smarttab           " Enable smart-tabs
set softtabstop=2      " Number of spaces per Tab

" Advanced
set ruler              " Show row and column ruler information

set undolevels=1000    " Number of undo levels
set backspace=indent,eol,start   " Backspace behaviour

let mapleader = " "

vnoremap <leader>y "+y
vnoremap <leader>p "+p
vnoremap <leader>P "+P
nnoremap <leader>p "+p
nnoremap <leader>P "+P

set background=dark
colorscheme gruvbox

lua require('adam')
