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

" Syntax
syntax enable
syntax on

" Colorscheme
colorscheme molokai

" Font
set guifont=Monaco:h14

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
    au InsertEnter * set timeoutlen=1000
    au InsertLeave * set timeoutlen=1000
augroup END
endif

" Beep
set visualbell
set noerrorbells

" Wrap and break
set wrap
set linebreak
let &showbreak="↳ " " ↪
set whichwrap=b,s,h,l,<,>,[,]

" No swap file
set nobackup
set noswapfile

" Auto read
set autoread

" Max undo times
set history=1000

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
set showtabline=2
set guioptions-=e

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

" Max text width
if exists('+colorcolumn')
    let &colorcolumn=join(range(80,999),",")
    highlight ColorColumn ctermbg=234 guibg=#262626
endif

" Map leader
let mapleader="\<Space>"

" Use bash shell
set shell=/bin/bash

" Word list
set dictionary=~/.vim/resource/words
set infercase

" Auto source the .vimrc
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

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
Plugin 'vim-scripts/lastpos.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'ervandew/supertab'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/syntastic'
Plugin 'godlygeek/tabular'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'b4winckler/vim-angry'
Plugin 'rking/ag.vim'
Plugin 'justinmk/vim-sneak'
Plugin 'bling/vim-bufferline'
Plugin 'itchyny/lightline.vim'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'terryma/vim-expand-region'
Plugin 'tpope/vim-dispatch'
Plugin 'mattn/emmet-vim'
Plugin 'SirVer/ultisnips'
Plugin 'csexton/jekyll.vim'
Plugin 'wikitopian/hardmode'

call vundle#end()
filetype plugin indent on

" NERDTree
let g:NERDTreeShowHidden=1
let g:NERDTreeQuitOnOpen=1

" Tagbar
let g:tagbar_autoclose=1
let g:tagbar_autofocus=1
let g:tagbar_compact=1
let g:tagbar_singleclick=1
let g:tagbar_iconchars=['+','-']
let g:tagbar_sort=0
let g:tagbar_show_linenumbers=1

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

" SuperTab
let g:SuperTabDefaultCompletionType="context"

" Syntastic
let g:syntastic_check_on_open=1

" Ag
let g:aghighlight=1

" Sneak
let g:sneak#streak=1
let g:sneak#use_ic_scs=1

" Bufferline
let g:bufferline_echo=0
let g:bufferline_active_buffer_left='➜ '
let g:bufferline_active_buffer_right=''

function! Bufferline()
    call bufferline#refresh_status()
    let b = g:bufferline_status_info.before
    let c = g:bufferline_status_info.current
    let a = g:bufferline_status_info.after
    let alen = strlen(a)
    let blen = strlen(b)
    let clen = strlen(c)
    let w = winwidth(0) * 4 / 11
    if w < alen+blen+clen
        let whalf = (w - strlen(c)) / 2
        let aa = alen > whalf && blen > whalf ? a[:whalf] : alen + blen < w - clen || alen < whalf ? a : a[:(w - clen - blen)]
        let bb = alen > whalf && blen > whalf ? b[-(whalf):] : alen + blen < w - clen || blen < whalf ? b : b[-(w - clen - alen):]
        return (strlen(bb) < strlen(b) ? '...' : '') . bb . c . aa . (strlen(aa) < strlen(a) ? '...' : '')
    else
        return b . c . a
    endif
endfunction

" Lightline
let g:lightline = {
\    'component_function': {
\        'bufferline': 'Bufferline'
\    },
\    'active': {
\        'left': [ [ 'mode', 'paste'  ], [ 'filename'  ], [ 'bufferline' ] ]
\    },
\    'tab': {
\        'active': [ 'tabnum', 'filename', 'modified' ],
\        'inactive': [ 'tabnum', 'filename', 'modified' ]
\    },
\    'tabline': {
\        'left': [ [ 'tabs' ] ],
\        'right': [ [ ] ]
\    }
\}

" Session
let g:session_autosave='yes'
let g:session_autoload='no'
let g:session_verbose_messages=0
let g:session_command_aliases=1

" Emmet
let g:user_emmet_leader_key='<C-e>'

" Ultisnips
let g:UltiSnipsSnippetDirectories=['vim-snippets']

" Jekyll
let g:jekyll_post_published='false'
let g:jekyll_path='~/Workspace/Repository/tang3w.github.com'

" Hardmode
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
let g:HardMode_hardmodeMsg="You are in hard mode!"
let g:HardMode_easymodeMsg="You are free now!"
let g:HardMode_level="wannabe"

" Mappings
inoremap <expr> <C-y> <SID>getWord(<SID>prevL())
inoremap <expr> <C-e> <SID>getWord(<SID>nextL())

nnoremap j                   gj
nnoremap k                   gk
nmap     <silent> <Leader>e  :NERDTreeToggle<CR>
nmap     <silent> <Leader>f  :CtrlP<CR>
nmap     <silent> <Leader>t  :TagbarToggle<CR>
nmap     <silent> <Leader>a  :FSHere<CR>
nmap              <Leader>g  :Ag!<space>
nnoremap          <Leader>b  :ls<CR>:b<space>
nmap              <Leader>so :SessionOpen<Space>
nmap              <Leader>ss :SessionSave<Space>
nmap     <silent> <Tab>      :bnext<CR>
nmap     <silent> <S-Tab>    :bprevious<CR>
nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>:set nopaste<CR>
nnoremap <silent> <C-l>      :nohlsearch<CR><C-l>
nmap              Q          <nop>
cnoremap <C-a>               <Home>
cnoremap <C-e>               <End>
