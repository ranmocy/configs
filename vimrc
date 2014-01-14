"No Compatible Mode
set nocp
"Status ruler
set ru
"Line number ruler
set nu
"Highlight when search
set hls
"Instant search
set is
"Ignore case when search
set ignorecase
"Syntax Highlight
syntax on
"Backspace behaviour
set backspace=indent,eol,start
"Encoding
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set ffs=unix,dos,mac
"Double width
set ambiwidth=double
"Filetype plugin
filetype plugin indent on

"Indent width
set shiftwidth=4
set tabstop=4
"Use space instead of tab
set expandtab
"Smart tab
set smarttab

"Line break
set tw=78
set lbr
set fo+=mB

"Status bar
set laststatus=2
" Format the status line
set statusline=%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
set wildmenu
colo desert

set autoread
set nobackup
set nowb
set noswapfile

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>
map <leader>tn :tabnew<cr>
map <leader>th :tabprevious<cr>
map <leader>tl :tabNext<cr>
map <leader>tm :tabmove
map <leader>tw :tabclose<cr>
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>
" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

