" Vim configuration
" Author by Tianyong Tang

" Be improved
set nocompatible

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

" Tab and space
set smarttab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Indent
set cindent
set autoindent
set cinoptions=(sus,L0
set copyindent
set preserveindent

" Multi-bytes character
set ambiwidth=double
set formatoptions+=mM

" Enable mouse
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif

" Syntax
syntax enable
syntax on

" Gruvbox colorscheme fix
let g:gruvbox_italic=0

" Colorscheme
set background=dark
colorscheme gruvbox

" Font
set guifont=Monaco:h16

" Backspace
set backspace=indent,eol,start

" Search rules
set hlsearch
set incsearch
set ignorecase
set smartcase

" Timeout
if ! has('gui_running')
set ttimeoutlen=10
augroup FastEscape
    autocmd!
    autocmd InsertEnter * set timeoutlen=1000
    autocmd InsertLeave * set timeoutlen=1000
augroup END
endif

" Beep
set visualbell t_vb=
set noerrorbells

" Highlight current line
augroup CursorLine
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

set lazyredraw

" Wrap and break
set wrap
set linebreak
let &showbreak="↳ "
set whichwrap=b,s,h,l,<,>,[,]

" No swap file
set nobackup
set noswapfile

" Auto read
set autoread

" Max undo times
set history=1000

" Cursor hold time
set updatetime=800

" Enable fold
set foldenable

" Show command list
set wildmenu

" Show number
set number

" Show ruler
set ruler

" No default mode
set noshowmode

" Tab line
set showtabline=1
set guioptions-=e

" Dictionary complete
set complete+=k

" No preview
set completeopt-=preview

" Popup menu height
set pumheight=15

" Hide scroll bar
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

" Make tab character visiable
set list
set listchars=tab:‣-

" Status line
set laststatus=2

" Virtual edit
set virtualedit=onemore

" Buffer hidden
set hidden

" Trailing whitespace
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
highlight EOLWS ctermbg=red guibg=red

" Map leader
let mapleader="\<Space>"

" Use bash shell
set shell=/bin/bash

" Word list
set infercase
set dictionary=~/.vim/resource/words

function s:prependDict(dicts)
    let dictlist = split(a:dicts, ',')
    let dictlist = map(dictlist, "'~/.vim/resource/'.v:val.'.dict'")
    execute 'setlocal dictionary='.join(dictlist, ',')
    setlocal dictionary+=~/.vim/resource/words
endfunction

autocmd FileType javascript call s:prependDict('javascript,node')

" FileType detect
autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown set filetype=markdown

" Copy previous or next nonblank line

function! s:prevL()
    let lnum = line('.') - 1
    while lnum > 0
        if match(getline(lnum), '^\s*$') < 0
            return lnum
        endif
        let lnum = lnum - 1
    endwhile
    return 0
endfunction

function! s:nextL()
    let lnum = line('.') + 1
    while lnum <= line('$')
        if match(getline(lnum), '^\s*$') < 0
            return lnum
        endif
        let lnum = lnum + 1
    endwhile
    return 0
endfunction

function! s:getWord(line)
    return matchstr(getline(a:line), '\%'.virtcol('.').'v\%(\w\+\s\=\|.\)')
endfunction

" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/matchit.zip'
Plugin 'ciaranm/detectindent'
Plugin 'kien/ctrlp.vim'
Plugin 'myusuf3/numbers.vim'
Plugin 'kshenoy/vim-signature'
Plugin 'dickeyxxx/status.vim'
Plugin 'vim-scripts/lastpos.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'mhinz/vim-signify'
Plugin 'sjl/gundo.vim'
Plugin 'szw/vim-kompleter'
Plugin 'ervandew/supertab'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-endwise'
Plugin 'scrooloose/syntastic'
Plugin 'benjumanji/vim-togglelist'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-repeat'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'b4winckler/vim-angry'
Plugin 'rking/ag.vim'
Plugin 'justinmk/vim-sneak'
Plugin 'mihaifm/bufstop'
Plugin 'yegappan/mru'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'terryma/vim-expand-region'
Plugin 'tpope/vim-dispatch'
Plugin 'thinca/vim-quickrun'
Plugin 'mattn/emmet-vim'
Plugin 'SirVer/ultisnips'
Plugin 'wikitopian/hardmode'

" Language specific plugins
Plugin 'justinmk/vim-syntax-extra'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'csexton/jekyll.vim'

call vundle#end()
filetype plugin indent on

" NERDTree
let g:NERDTreeShowHidden=1
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeMouseMode=2
let g:NERDTreeMapCWD='-'

" Tagbar
let g:tagbar_autoclose=1
let g:tagbar_autofocus=1
let g:tagbar_compact=1
let g:tagbar_singleclick=1
let g:tagbar_iconchars=['+','-']
let g:tagbar_sort=0

" NerdCommenter
let NERDSpaceDelims=1

" Detectindent
let g:detectindent_preferred_expandtab=1
let g:detectindent_preferred_indent=4
let g:detectindent_max_lines_to_analyse=1024

" Ctrlp
let g:ctrlp_map=""
let g:ctrlp_by_filename=1
let g:ctrlp_match_window="order:ttb"
let g:ctrlp_show_hidden=1
let g:ctrlp_open_new_file="t"

" Numbers
let g:numbers_exclude=['tagbar', 'gundo', 'nerdtree', 'quickrun']

" Status
let g:statusline_order = [
    \ 'Filename',
    \ 'CheckUnix',
    \ 'Encoding',
    \ 'Filetype',
    \ 'Modified',
    \ 'Fugitive',
    \ 'Syntastic',
    \ 'Paste',
    \ 'ReadOnly',
    \ 'RightSeperator',
    \ 'CursorColumn',
    \ 'LineAndTotal',
    \ 'FilePercent']

" Signify
let g:signify_sign_delete='-'
let g:signify_sign_delete_first_line='-'
let g:signify_sign_change = '~'

" Gundo
let g:gundo_right=1
let g:gundo_close_on_revert=1

" Kompleter
let g:kompleter_replace_standard_mappings=0
let g:kompleter_case_sensitive=2

" SuperTab
let g:SuperTabDefaultCompletionType="context"
let g:SuperTabContextDefaultCompletionType="<C-x><C-u>"
let g:SuperTabClosePreviewOnPopupClose=1

" Syntastic
let g:syntastic_aggregate_errors=1
let g:syntastic_enable_highlighting=0
let g:syntastic_always_populate_loc_list=1
let g:syntastic_python_checkers=['pyflakes', 'pep8']
let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_ruby_checkers=['rubocop']

function s:autoSave()
    if &modifiable && &modified
        silent! noautocmd write
        call sy#start(b:sy_path)
        SyntasticCheck
    endif
endfunction

autocmd CursorHold * call s:autoSave()

" ToggleList
let g:toggle_list_restore=0

" Ag
let g:aghighlight=1

" Sneak
let g:sneak#streak=1
let g:sneak#use_ic_scs=1

" MRU
let MRU_Exclude_Files='.git/*'

" Session
let g:session_autosave='yes'
let g:session_autoload='no'
let g:session_verbose_messages=0
let g:session_command_aliases=1

let g:expand_region_text_objects = {
    \   'iw' : 0,
    \   'iW' : 0,
    \   'i"' : 1,
    \   'i''': 1,
    \   'i]' : 1,
    \   'ia' : 0,
    \   'ib' : 1,
    \   'iB' : 1,
    \   'ip' : 0,
    \   'ii' : 0
    \ }

" Quickrun
let g:quickrun_config={}
let g:quickrun_config["_"]={
    \   'outputter/buffer/split': ':botright 8sp',
    \   'outputter/buffer/close_on_empty': 1,
    \   'outputter/buffer/into': 1,
    \ }

" Emmet
let g:user_emmet_mode='i'
let g:user_emmet_leader_key='<C-k>'

" Ultisnips
let g:UltiSnipsSnippetDirectories=['vim-snippets']

" Jekyll
let g:jekyll_post_published='false'
let g:jekyll_path='~/Workspace/Repository/tang3w.github.com'

" Hardmode
let g:HardMode_level="wannabe"
let g:HardMode_hardmodeMsg="You are in hard mode!"
let g:HardMode_easymodeMsg="You are free now!"
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

" FileTypes
function s:expandTabTo2Space()
    setlocal tabstop=2 shiftwidth=2 softtabstop=2
endfunction

autocmd FileType ruby,javascript,css,html call s:expandTabTo2Space()

" Commands
command W w !sudo tee % > /dev/null

" Autocmds
function s:closeqf()
    silent! lclose
    silent! cclose
endfunction

autocmd FileType qf nnoremap <silent> <buffer> <CR> <CR>:call <SID>closeqf()<CR>
autocmd FileType qf nmap <silent> <buffer> q :call <SID>closeqf()<CR>

" Mappings
cmap <C-a> <Home>
cmap <C-e> <End>

imap <expr> <C-y> <SID>getWord(<SID>prevL())
imap <expr> <C-e> <SID>getWord(<SID>nextL())

function s:refresh()
    let @/ = ""
    if sneak#is_sneaking()
        call sneak#cancel()
    endif
endfunction

function s:toggleNERDTree()
    if nerdtree#isTreeOpen()
        NERDTreeClose
    elseif filereadable(expand("%:p"))
        NERDTreeFind
    else
        NERDTreeCWD
    endif
endfunction

nnoremap <silent> <C-l>      :call <SID>refresh()<CR><C-l>
nmap     <silent> <Esc><Esc> :call <SID>refresh()<CR>:set nopaste<CR>

nmap <silent> <Tab>     :bnext<CR>
nmap <silent> <S-Tab>   :bprevious<CR>
nmap <silent> <Leader>a :FSHere<CR>
nmap <silent> <Leader>b :BufstopFast<CR>
nmap <silent> <Leader>e :call <SID>toggleNERDTree()<CR>
nmap <silent> <Leader>f :CtrlP<CR>
nmap          <Leader>g :Ag!<space>
nmap <silent> <Leader>m :MRU<CR>
map  <silent> <Leader>r <Plug>(quickrun)
nmap <silent> <Leader>t :TagbarToggle<CR>
nmap <silent> <Leader>u :GundoToggle<CR>
map  <silent> <Leader>/ <plug>NERDCommenterToggle
nmap <silent> ]l :lnext<CR>
nmap <silent> [l :lprev<CR>
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T
nmap Q <Nop>
nmap j gj
nmap k gk
