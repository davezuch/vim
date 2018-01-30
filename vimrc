if has('mac')
  let g:python_host_prog = '/usr/local/bin/python2'
elseif has('unix')
  let g:python_host_prog = '/usr/bin/python2'
endif

" use system clipboard
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif
let g:mapleader = "\<Space>"

" Autoinstall vim-plug (https://github.com/junegunn/vim-plug)
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
" Plugins initialization start
call plug#begin('~/.vim/plugged')

Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/vim-easy-align'
Plug 'pangloss/vim-javascript'
Plug 'crusoexia/vim-javascript-lib'
Plug 'scrooloose/nerdtree'
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
Plug 'ctrlpvim/ctrlp.vim'
"set path+=**
set wildignore+=*/node_modules/*,*/vendor/*,*/bower_components/*,*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.git
"toggle NERDTree with space-nt
map <leader>nt :NERDTreeToggle<CR>
"find current file in NERDTree with space-nf
map <leader>nf :NERDTreeFind<CR>
Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim'
Plug 'shawncplus/phpcomplete.vim'
Plug 'Valloric/YouCompleteMe'
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
Plug 'scrooloose/syntastic'
Plug 'nvie/vim-flake8'
Plug 'terryma/vim-multiple-cursors'
Plug 'lambdatoast/elm.vim'
Plug 'raichoo/purescript-vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
set laststatus=2
Plug 'frigoeu/psc-ide-vim'
let g:psc_ide_import_on_completion = v:false
"psc-ide bindings
au FileType purescript nm <buffer> <silent> <leader>t :<C-U>call PSCIDEtype(PSCIDEgetKeyword(), v:true)<CR>
au FileType purescript nm <buffer> <silent> <leader>T :<C-U>call PSCIDEaddTypeAnnotation(matchstr(getline(line(".")), '^\s*\zs\k\+\ze'))<CR>
au FileType purescript nm <buffer> <silent> <leader>s :<C-U>call PSCIDEapplySuggestion()<CR>
au FileType purescript nm <buffer> <silent> <leader>a :<C-U>call PSCIDEaddTypeAnnotation()<CR>
au FileType purescript nm <buffer> <silent> <leader>i :<C-U>call PSCIDEimportIdentifier(PSCIDEgetKeyword())<CR>
au FileType purescript nm <buffer> <silent> <leader>r :<C-U>call PSCIDEload()<CR>
au FileType purescript nm <buffer> <silent> <leader>p :<C-U>call PSCIDEpursuit(PSCIDEgetKeyword())<CR>
au FileType purescript nm <buffer> <silent> <leader>C :<C-U>call PSCIDEcaseSplit("!")<CR>
au FileType purescript nm <buffer> <silent> <leader>f :<C-U>call PSCIDEaddClause("")<CR>
au FileType purescript nm <buffer> <silent> <leader>qa :<C-U>call PSCIDEaddImportQualifications()<CR>
au FileType purescript nm <buffer> <silent> ]d :<C-U>call PSCIDEgoToDefinition("", PSCIDEgetKeyword())<CR>
"Plug 'kana/vim-fakeclip'
Plug 'tpope/vim-surround'
Plug 'hdima/python-syntax'
Plug 'djoshea/vim-autoread'

call plug#end()

" basic settings
filetype plugin indent on
set backspace=2
set encoding=utf-8
set tabstop=2
set softtabstop=2
set shiftwidth=2
"extension based indent settings
au BufNewFile,BufRead *.{py,hs,rs}
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set fileformat=unix
set textwidth=100
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
"indent text and rehighlight -- vim tip_id=224
vnoremap > ><CR>gv
vnoremap < <<CR>gv

" splits
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" style
syntax enable
set t_Co=256
let python_highlight_all=1
set hlsearch
highlight VertSplit cterm=none gui=none

" basics
inoremap jk <ESC>
imap <BS> <Left><Del>
" enable folding
set foldmethod=indent
set foldlevel=99
"nnoremap <dd> za " remap space to fold

"search for word under cursor with space-s
map <leader>s /<C-r><C-w><CR>

"toggle search highlighting with space-h
map <leader>h :set hlsearch! hlsearch?<CR>

" plugin settings

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_php_checkers = ['php']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_checkers = ['eslint']
let g:syntastic_python_flake8_args='--ignore=E402 --max-line-length=100'

" filetype settings
"au FileType javascript setl sw=2 sts=2 ts=2
au BufNewFile,BufRead *.js,*.html,*.css,*.sass,*.php
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

