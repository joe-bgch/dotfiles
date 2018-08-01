" Vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'joonty/vdebug'
Plugin 'flazz/vim-colorschemes'
Plugin 'ColorSchemeMenuMaker'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Chiel92/vim-autoformat'
Plugin 'sh.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'airblade/vim-gitgutter'

call vundle#end()
filetype plugin indent on

" General settings

" Set encoding
set encoding=utf-8

" Enable 256 colors
set t_Co=256

" Set colorscheme
colorscheme darcula

" Highlight current line
set cursorline

" Line numbers
set number

" Syntax highlight
syntax on

" Change backup / swap / undo directories. Make sure to create these directories first
" The // suffix is to avoid filename collisions when editing files with same name
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" Allow saving of files as sudo
cmap w!! w !sudo tee > /dev/null %
cnoremap sudow w !sudo tee % >/dev/null

" Don't show mode indicator (the airline provided one is enough)
set noshowmode

" Faster UI updates
set updatetime=750

set timeoutlen=1000 ttimeoutlen=0

" Turn on smart indenting
filetype indent on
set smartindent

let mapleader = "\<Space>"
nnoremap <Leader>n :CtrlP<CR>
nnoremap <Leader>w :w<CR>

set ignorecase            " Make searches case-insensitive.
set incsearch             " show match as search proceeds
set hlsearch              " search highlighting
set tabstop=4             " tab spacing
set softtabstop=4         " unify
set shiftwidth=4          " indent/outdent by 4 columns
set shiftround            " always indent/outdent to the nearest tabstop
set expandtab             " use spaces instead of tabs
set nowrap                " don't wrap text

set mousefocus

set whichwrap+=<,>,h,l,[,]
set ambiwidth=double

if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" Plugin settings

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
set laststatus=2
let g:airline_theme = 'powerlineish'
let g:airline_powerline_fonts = 1

" CtrlP
nmap <leader>b :CtrlPBuffer<CR>

