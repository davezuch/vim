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
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim'
Plug 'shawncplus/phpcomplete.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'
Plug 'nvie/vim-flake8'

call plug#end()

" basic settings
filetype plugin indent on
set encoding=utf-8
set tabstop=4
set softtabstop=4
set shiftwidth=4
"set textwidth=79
set expandtab
set autoindent
set fileformat=unix
set number
set list
set listchars=tab:▸\ 
highlight ExtraWhiteSpace ctermbg=red guibg=red
match ExtraWhiteSpace /\s\+$/
autocmd BufWinEnter * match ExtraWhiteSpace /\s\+$/
autocmd InsertEnter * match ExtraWhiteSpace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhiteSpace /\s\+$/
autocmd BufWinLeave * call clearmatches()
set path+=**
set wildignore+=*/node_modules/*,*/vendor/*,*/bower_components/*,*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.git

" splits
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" style
syntax on
set background=dark
colorscheme lucario
set t_Co=256  " vim-monokai now only support 256 colours in terminal.
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1
let python_highlight_all=1

" basics
inoremap jk <ESC>
let mapleader = "\<Space>"
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
imap <BS> <Left><Del>
" enable folding
set foldmethod=indent
set foldlevel=99
"nnoremap <dd> za " remap space to fold

" plugin settings
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" filetype settings
"au FileType javascript setl sw=2 sts=2 ts=2
au BufNewFile,BufRead *.js,*.html,*.css,*.sass,*.php
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

" python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

