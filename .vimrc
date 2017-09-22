execute pathogen#infect()

"---Syntastic

let g:syntastic_check_on_open = 1
let g:syntastic_echo_current_error = 1
let g:syntastic_enable_signs = 1
let g:syntastic_enable_highlighting = 1

" JavaScript
"let g:syntastic_javascript_checkers = ["eslint"]

"let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_vue_checkers = ['eslint']
"let local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'
"if matchstr(local_eslint, "^\/\\w") == ''
"    let local_eslint = getcwd() . "/" . local_eslint
"endif
"if executable(local_eslint)
"    let g:syntastic_javascript_eslint_exec = local_eslint
"    let g:syntastic_vue_eslint_exec = local_eslint

" Ruby
"let g:syntastic_ruby_checkers = ['rubocop']
"let g:vimrubocop_config = '~/rubocop.yml'


"----------------------------
endif
syntax on
colorscheme jellybeans
set ruler
set showmatch
set showmode
set autoindent
set ignorecase
set smartcase
set relativenumber
set number
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
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
" remove trailing spaces
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

map ;p "+p
map ;y "+y

nnoremap H gT
nnoremap L gt
