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
Plugin 'bling/vim-airline'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Chiel92/vim-autoformat'
Plugin 'sh.vim'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'airblade/vim-gitgutter'

call vundle#end()
filetype plugin indent on

" General settings

" Enable 256 colors
set t_Co=256

" Set colorscheme
colorscheme elda

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

" Turn on smart indenting
filetype indent on
set smartindent

let mapleader = "\<Space>"
nnoremap <Leader>n :CtrlP<CR>
nnoremap <Leader>w :w<CR>

set ignorecase            " Make searches case-insensitive.
set tabstop=4             " tab spacing
set softtabstop=4         " unify
set shiftwidth=4          " indent/outdent by 4 columns
set shiftround            " always indent/outdent to the nearest tabstop
set expandtab             " use spaces instead of tabs
set nowrap                " don't wrap text

set mousefocus

set whichwrap+=<,>,h,l,[,]
set ambiwidth=double

" Plugin settings

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
set laststatus=2
let g:airline_theme = 'powerlineish'
let g:airline_powerline_fonts = 1

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Tagbar
nmap <F8> :TagbarToggle<CR>
