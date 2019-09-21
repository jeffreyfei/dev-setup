"call plug#begin('~/.vim/plugged')

"Plug 'lervag/vimtex'

"call plug#end()

execute pathogen#infect()

"---Syntastic

let g:syntastic_check_on_open = 1
let g:syntastic_echo_current_error = 1
let g:syntastic_enable_signs = 1
let g:syntastic_enable_highlighting = 1

"----------------------------
"endif
syntax on

syntax enable
"set background=dark
"colorscheme solarized

colorscheme jellybeans

" Indentation rules
set tabstop=4
set shiftwidth=2
set autoindent
filetype indent on
set expandtab

set ruler
set showmatch
set showmode
set ignorecase
set smartcase
set relativenumber
set number
highlight ColorColumn ctermbg=7
set colorcolumn=80

" Automcomplete
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

" Search improvements
set incsearch
set hlsearch
nmap <silent> <BS> :nohlsearch<CR>

" Always show the status line
set laststatus=2

" Treat long lines as break lines
map j gj
map k gk

" redefine tabs
" filetype plugin indent on
" set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
" remove trailing spaces
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" nerd tree config
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

map ;p "+p
map ;y "+y

nnoremap H gT
nnoremap L gt
