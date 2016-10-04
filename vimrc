if has('mac')
  let g:python_host_prog = '/usr/local/bin/python2'
elseif has('unix')
  let g:python_host_prog = '/usr/bin/python2'
endif

let g:mapleader = "\<Space>"

" Autoinstall vim-plug (https://github.com/junegunn/vim-plug) {{{
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
" }}}
call plug#begin('~/.vim/plugged') " Plugins initialization start {{{
" }}}
"
" Appearance
" ==================================================================
Plug 'dracula/vim'
Plug 'itchyny/lightline.vim'
" {{{
  set laststatus=2 " always show status bar
  " Neovim-qt Guifont command, to change the font
  command -nargs=? Guifont call rpcnotify(0, 'Gui', 'SetFont', "<args>")
  " Set font on start
  let g:Guifont = "Hack for Powerline:h13"
  let g:lightline = {
        \ 'colorscheme': 'solarized',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'fugitive', 'gitgutter', 'filename' ] ],
        \   'right': [ [ 'percent', 'lineinfo' ],
        \              [ 'syntastic' ],
        \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
        \ },
        \ 'component_function': {
        \   'fugitive': 'LightLineFugitive',
        \   'gitgutter': 'LightLineGitGutter',
        \   'readonly': 'LightLineReadonly',
        \   'modified': 'LightLineModified',
        \   'syntastic': 'SyntasticStatuslineFlag',
        \   'filename': 'LightLineFilename'
        \ },
        \ 'separator': { 'left': '▓▒░', 'right': '░▒▓' },
        \ 'subseparator': { 'left': '>', 'right': '' }
        \ }

  function! LightLineModified()
    if &filetype == "help"
      return ""
    elseif &modified
      return "+"
    elseif &modifiable
      return ""
    else
      return ""
    endif
  endfunction

  function! LightLineReadonly()
    if &filetype == "help"
      return ""
    elseif &readonly
      return "🔒"
    endif
    return ""
  endfunction

  function! LightLineFugitive()
    return exists('*fugitive#head') ? fugitive#head() : ''
  endfunction

  function! LightLineGitGutter()
    if ! exists('*GitGutterGetHunkSummary')
          \ || ! get(g:, 'gitgutter_enabled', 0)
          \ || winwidth('.') <= 90
      return ''
    endif
    let symbols = [
          \ g:gitgutter_sign_added,
          \ g:gitgutter_sign_modified,
          \ g:gitgutter_sign_removed
          \ ]
    let hunks = GitGutterGetHunkSummary()
    let ret = []
    for i in [0, 1, 2]
      if hunks[i] > 0
        call add(ret, symbols[i] . hunks[i])
      endif
    endfor
    return join(ret, ' ')
  endfunction

  function! LightLineFilename()
    return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
  endfunction

  " {{{ Modified theme
  let s:base03    = [ '#151513', 233 ]
  let s:base02    = [ '#30302c', 236 ]
  let s:base01    = [ '#4e4e43', 237 ]
  let s:base00    = [ '#666656', 242 ]
  let s:base0     = [ '#808070', 244 ]
  let s:base1     = [ '#949484', 246 ]
  let s:base2     = [ '#a8a897', 248 ]
  let s:base3     = [ '#e8e8d3', 253 ]
  let s:yellow    = [ '#ffb964', 215 ]
  let s:red       = [ '#cf6a4c', 167 ]
  let s:magenta   = [ '#f0a0c0', 217 ]
  let s:blue      = [ '#7697D6', 4   ]
  let s:orange    = [ '#ffb964', 215 ]
  let s:green     = [ '#99ad6a', 107 ]
  let s:white     = [ '#FCFCFC', 15  ]

  let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}, 'terminal': {}}
  let s:p.normal.left     = [ [ s:white, s:blue ], [ s:base3, s:base02 ] ]
  let s:p.normal.right    = [ [ s:base02, s:base1 ], [ s:base3, s:base02 ] ]
  let s:p.inactive.right  = [ [ s:base02, s:base00 ], [ s:base0, s:base02 ] ]
  let s:p.inactive.left   = [ [ s:base0, s:base02 ], [ s:base00, s:base02 ] ]
  let s:p.insert.left     = [ [ s:base02, s:orange ], [ s:base3, s:base01 ] ]
  let s:p.replace.left    = [ [ s:base02, s:red ], [ s:base3, s:base01 ] ]
  let s:p.visual.left     = [ [ s:base02, s:magenta ], [ s:base3, s:base01 ] ]
  let s:p.terminal.left   = [ [ s:base02, s:green ], [ s:base3, s:base01 ] ]
  let s:p.normal.middle   = [ [ s:base0, s:base03 ] ]
  let s:p.inactive.middle = [ [ s:base00, s:base02 ] ]
  let s:p.tabline.left    = [ [ s:base3, s:base02 ] ]
  let s:p.tabline.tabsel  = [ [ s:white, s:blue ] ]
  let s:p.tabline.middle  = [ [ s:base01, s:base03 ] ]
  let s:p.tabline.right   = [ [ s:base03, s:base03 ], [ s:base03, s:base03 ] ]
  let s:p.normal.error    = [ [ s:red, s:base02 ] ]
  let s:p.normal.warning  = [ [ s:yellow, s:base01 ] ]
  " }}}
" }}}
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
Plug 'crusoexia/vim-monokai'
Plug 'pangloss/vim-javascript'
Plug 'crusoexia/vim-javascript-lib'
Plug 'raphamorim/lucario'
Plug 'cseelus/vim-colors-lucid'
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
set tabstop=2
set softtabstop=2
set shiftwidth=2
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
"set path+=**
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
colorscheme dracula
set t_Co=256
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1
let python_highlight_all=1
set hlsearch

" basics
inoremap jk <ESC>
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
imap <BS> <Left><Del>
" enable folding
set foldmethod=indent
set foldlevel=99
"nnoremap <dd> za " remap space to fold

" plugin settings
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_php_checkers = ['php', 'phpmd']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_checkers = ['eslint']

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

