" pathogen first
" execute pathogen#infect()

" vim-plug (https://github.com/junegunn/vim-plug)
call plug#begin('~/.vim/plugged')

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
Plug 'crusoexia/vim-monokai'
Plug 'pangloss/vim-javascript'
Plug 'crusoexia/vim-javascript-lib'
Plug 'raphamorim/lucario'
Plug 'cseelus/vim-colors-lucid'
Plug 'dracula/vim'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp'

call plug#end()

" basic settings
filetype plugin indent on
set encoding=utf-8
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set number
set list
set listchars=tab:▸\ ,eol:¬

" style
" set background=dark
syntax on
colorscheme lucario
set t_Co=256  " vim-monokai now only support 256 colours in terminal.
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1

" basics
inoremap jk <ESC>
let mapleader = "\<Space>"

" mappings
imap <BS> <Left><Del>

" filetype settings
au FileType javascript setl sw=2 sts=2 ts=2

