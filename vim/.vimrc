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

call vundle#end()            " required
filetype plugin indent on    " required

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

set whichwrap+=<,>,h,l,[,]
set expandtab
set shiftwidth=4
set softtabstop=4

" vim-airline
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
set noshowmode
set ambiwidth=double
let g:airline_theme = 'powerlineish'
let g:airline_powerline_fonts = 1

" Turn on smart indenting
filetype indent on
set smartindent

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
