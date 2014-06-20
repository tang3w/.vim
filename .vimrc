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

" Multi-bytes character
set ambiwidth=double
set formatoptions+=mM

" Syntax
syntax enable
syntax on

" Highlight current column and line
set cursorcolumn
set cursorline
au BufLeave * set nocursorline nocursorcolumn
au BufEnter * set cursorline cursorcolumn

" Backspace
set backspace=indent,eol,start

" Search rules
set is
set hlsearch
set ignorecase

" Wrap and break
set wrap
set linebreak
let &showbreak="↳ " " ↪
set whichwrap=b,s,h,l,<,>,[,]

" No swap file
set noswapfile

" Enable fold
set foldenable

" Show command list
set wildmenu

" Show number
set number

" Show ruler
set ruler

" Map leader
let mapleader=" "

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
Plugin 'scrooloose/nerdtree'

call vundle#end()
filetype plugin indent on

" Mappings
noremap <silent> <Leader>1 :NERDTreeToggle<CR>
