" General options
filetype plugin on
filetype indent on
set number
set signcolumn=no
set cursorline
set textwidth=80
set ruler
set nowrap

set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

set autoindent
set smartindent

set splitright
set splitbelow

" you must run mkdir $HOME/.vim/swap $HOME/.vim/undo $HOME/.vim/backup
set undofile
set autochdir

set incsearch
set hlsearch
set ignorecase
set smartcase

set wildmenu
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
set wildmode=longest:full,full

syntax on
set colorcolumn=80
colorscheme gruvbox
let g:gruvbox_contrast_dark = "hard"
set bg=dark

" Maps and remaps
let mapleader = ","
let maplocalleader = "."

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nmap <leader>o <C-W>\|<C-W>_
nmap <leader>i <C-W>=

nmap <C-n> gt
nmap <C-b> gT

map <leader><Space> :nohlsearch<cr>
map <leader>s :setlocal spell!<cr>
map <leader>pp :setlocal paste!<cr>

" File explorer (netrw)
let g:netrw_liststyle = 3
let g:netrw_banner = 0

" Options for filetypes
autocmd FileType markdown :setlocal wrap
autocmd FileType nix :packadd vim-nix

" functions

" https://stackoverflow.com/a/8462159
function! EnsureDirExists (dir)
  if !isdirectory(a:dir)
    if exists("*mkdir")
      call mkdir(a:dir,'p')
      echo "Created directory: " . a:dir
    else
      echo "Please create directory: " . a:dir
    endif
  endif
endfunction

" PLUGIN CONFIGS

let g:ackprg = '${pkgs.ag}/bin/ag --vimgrep'
map <leader>f :Ack! 
