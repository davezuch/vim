" pathogen first
" execute pathogen#infect()
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

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
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim'

call plug#end()

" basic settings
filetype plugin indent on
set encoding=utf-8
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
set autoindent
set fileformat=unix
set number
set list
set listchars=tab:▸\ ,eol:¬

" splits
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

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
imap <BS> <Left><Del>
" enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za " remap space to fold

" filetype settings
au BufNewFile,BufRead *.js, *.html, *.css, *.sass
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2
"au FileType javascript setl sw=2 sts=2 ts=2

