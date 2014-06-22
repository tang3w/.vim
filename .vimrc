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
set cinoptions=(sus
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
set guifont=Monaco:h16

" Backspace
set backspace=indent,eol,start

" Search rules
set hlsearch
set incsearch
set ignorecase
set smartcase

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

" Enable fold
set foldenable

" Show command list
set wildmenu

" Show number
set number

" Show ruler
set ruler

" Trailing whitespace
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
highlight EOLWS ctermbg=red guibg=red

" Map leader
let mapleader="\<Space>"

" Use bash shell
set shell=/bin/bash

" Auto source the .vimrc
autocmd! BufWritePost .vimrc source ~/.vimrc

" Copy previous or next nonblank line
function! s:nextL()
    let lnum = line('.') + 1
    while lnum <= line('$')
        if match(getline(lnum), '^\s*$') < 0
            return lnum
        endif
        let lnum = lunm + 1
    endwhile
    return 0
endfunction

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

function! s:getWord(line)
    return matchstr(getline(a:line), '\%'.virtcol('.').'v\%(\w\+\s\=\|.\)')
endfunction

function! s:getUnit(line)
    return matchstr(getline(a:line), '\%'.virtcol('.').'v\%(\S\+\s\=\|.\)')
endfunction

imap <expr> <C-g>y <SID>getWord(<SID>prevL())
imap <expr> <C-g><C-y> <SID>getWord(<SID>prevL())

imap <expr> <C-g>e <SID>getWord(<SID>nextL())
imap <expr> <C-g><C-e> <SID>getWord(<SID>nextL())

imap <expr> <C-g>u <SID>getUnit(<SID>prevL())
imap <expr> <C-g><C-u> <SID>getUnit(<SID>prevL())

imap <expr> <C-g>r <SID>getUnit(<SID>nextL())
imap <expr> <C-g><C-r> <SID>getUnit(<SID>nextL())

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
Plugin 'justinmk/vim-sneak'
Plugin 'myusuf3/numbers.vim'
Plugin 'vim-scripts/lastpos.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'ervandew/supertab'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/syntastic'
Plugin 'godlygeek/tabular'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'rking/ag.vim'

call vundle#end()
filetype plugin indent on

" Lightline
set laststatus=2

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
let g:ctrlp_by_filename=1
let g:ctrlp_match_window="order:ttb"
let g:ctrlp_show_hidden=1
let g:ctrlp_open_new_file="t"

" Ag
let g:aghighlight=1

" Mappings
noremap <silent> <Leader>e :NERDTreeToggle<CR>
noremap <silent> <Leader>f :CtrlP<CR>
noremap <silent> <Leader>t :TagbarToggle<CR>
noremap <Leader>/ :Ag!<space>
