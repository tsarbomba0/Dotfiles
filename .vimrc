" colo wal
syntax on

let mapleader = ','

let g:netrw_winsize       = -28
let g:netrw_liststyle     = 3
let g:netrw_sort_sequence = '[\/]$,*'
let g:netrw_browse_split  = 3

call plug#begin('~/.vim/plugged')

call plug#end()

Plug 'tomtom/tcomment_vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'vim-syntastic/syntastic'

"let g:lightline = { 'colorscheme': 'wal', }

"set laststatus=2
set noshowmode

"set  rtp+=/home/comfy/.local/lib/python3.7/site-packages/powerline/bindings/vim/
"set laststatus=2
"set t_Co=256
