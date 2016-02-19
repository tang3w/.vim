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

" Clipboard
set clipboard^=unnamed,unnamedplus

" Multi-bytes character
set ambiwidth=double
set formatoptions+=mM

" Syntax
syntax enable
syntax on

" Font
set guifont=ConsolasHigh:h18

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
set nowrap
set linebreak
let &showbreak='↳ '
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
autocmd FileType vim call s:prependDict('vim')

" FileType detect
autocmd FileType markdown setlocal spell
autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown setlocal filetype=markdown
autocmd BufRead,BufNewFile *.m,*.mm,*.pch setlocal filetype=objc

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
Plugin 'dietsche/vim-lastplace'
Plugin 'tpope/vim-fugitive'
Plugin 'mhinz/vim-signify'
Plugin 'sjl/gundo.vim'
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
Plugin 'tang3w/mru'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'mhinz/vim-startify'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'terryma/vim-expand-region'
Plugin 'tpope/vim-dispatch'
Plugin 'thinca/vim-quickrun'
Plugin 'mattn/emmet-vim'
Plugin 'SirVer/ultisnips'
Plugin 'jeetsukumaran/vim-buffersaurus'
Plugin 'vim-scripts/CmdlineComplete'
Plugin 'morhetz/gruvbox'
Plugin 'maxbrunsfeld/vim-yankstack'
Plugin 'haya14busa/vim-asterisk'
Plugin 'vim-scripts/ShowTrailingWhitespace'
Plugin 'wikitopian/hardmode'

" Language specific plugins
Plugin 'justinmk/vim-syntax-extra'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'vim-scripts/indenthtml.vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'csexton/jekyll.vim'
Plugin 'keith/swift.vim'

call vundle#end()
filetype plugin indent on

" Gruvbox colorscheme fix
let g:gruvbox_italic=0
let g:gruvbox_invert_selection=0

" Colorscheme
set background=dark
colorscheme gruvbox

" NERDTree
let g:NERDTreeShowHidden=1
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeMouseMode=2
let g:NERDTreeMapCWD='-'
let NERDTreeIgnore=['\.DS_Store']

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
let g:ctrlp_map=''
let g:ctrlp_by_filename=1
let g:ctrlp_match_window='order:ttb'
let g:ctrlp_show_hidden=1
let g:ctrlp_open_new_file='r'

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
let g:signify_sign_change='~'
let g:signify_mapping_toggle='<Nop>'
let g:signify_mapping_toggle_highlight='<Nop>'
let g:signify_mapping_next_hunk='<Nop>'
let g:signify_mapping_prev_hunk='<Nop>'

" Gundo
let g:gundo_right=1
let g:gundo_close_on_revert=1

" SuperTab
let g:SuperTabDefaultCompletionType='context'
let g:SuperTabContextDefaultCompletionType='<C-n>'
let g:SuperTabClosePreviewOnPopupClose=1

" Auto pairs
let g:AutoPairsCenterLine=0

" Syntastic
let g:syntastic_aggregate_errors=1
let g:syntastic_enable_highlighting=0
let g:syntastic_always_populate_loc_list=1
let g:syntastic_python_checkers=['pyflakes', 'pep8']
let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_ruby_checkers=['rubocop']

" ToggleList
let g:toggle_list_restore=0

" Ag
let g:aghighlight=1

" Sneak
let g:sneak#streak=1
let g:sneak#use_ic_scs=1
let g:sneak#target_labels="fgqwertyupzvbnmFGQWERTYUPZVBNM1234567890"

" MRU
let MRU_Exclude_Files='.git/*'

" Session
let g:session_autosave='yes'
let g:session_autoload='no'
let g:session_verbose_messages=0
let g:session_command_aliases=1

" Startify
let g:startify_session_dir='~/.vim/sessions'
let g:startify_list_order=['sessions', 'files', 'dir', 'bookmarks']

" Multiple Cursors
let g:multi_cursor_quit_key='<C-c>'

" Expand region
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
let g:quickrun_config={
    \   'objc': {
    \     'command': 'cc',
    \     'exec': ['%c %s -o %s:p:r -framework Foundation', '%s:p:r %a', 'rm -f %s:p:r'],
    \     'tempfile': '%{tempname()}.m'
    \   },
    \   '_': {
    \     'outputter/buffer/split': ':botright 8sp',
    \     'outputter/buffer/close_on_empty': 1,
    \     'outputter/buffer/into': 1
    \   }
    \ }

" Emmet
let g:user_emmet_mode='i'
let g:user_emmet_leader_key='<C-k>'

" Ultisnips
let g:UltiSnipsSnippetDirectories=['UltiSnips']
let g:UltiSnipsJumpForwardTrigger='<Tab>'
let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'
let g:UltiSnipsEditSplit='vertical'

" Jekyll
let g:jekyll_post_published='false'
let g:jekyll_path='~/Workspace/Repository/tang3w.github.com'

" Buffersaurus
let g:buffersaurus_flash_jumped_line=0

" YankStack
call yankstack#setup()

" Hardmode
let g:HardMode_level='wannabe'
let g:HardMode_hardmodeMsg='You are in hard mode!'
let g:HardMode_easymodeMsg='You are free now!'
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

" Indent HTML
let g:html_indent_inctags='html,body,head,tbody'
let g:html_indent_script1='inc'
let g:html_indent_style1='inc'

" FileTypes
function s:setTabWidth(num)
    exec 'setlocal tabstop='.a:num.' shiftwidth='.a:num.' softtabstop='.a:num
endfunction

autocmd FileType ruby,javascript,scss,css call s:setTabWidth(2)
autocmd FileType html,yaml,html.handlebars setlocal noexpandtab

" Commands
command W w !sudo tee % > /dev/null

" Autocmds
function s:closeqf()
    silent! lclose
    silent! cclose
endfunction

autocmd FileType qf nnoremap <silent> <buffer> <CR> <CR>:call <SID>closeqf()<CR>
autocmd FileType qf nmap <silent> <buffer> q :call <SID>closeqf()<CR>

function s:autoHeader(prg)
    0put='#!/usr/bin/env '.a:prg.\"\n\"|$
endfunction

autocmd BufNewFile *.py call <SID>autoHeader('python')
autocmd BufNewFile *.rb call <SID>autoHeader('ruby')
autocmd BufNewFile *.sh call <SID>autoHeader('bash')

function s:afterColors()
    if exists('g:colors_name') && strlen(g:colors_name)
        execute 'runtime! after/colors/all.vim'
        execute 'runtime! after/colors/'.g:colors_name.'.vim'
    endif
endfunction

autocmd VimEnter,ColorScheme * call <SID>afterColors()

" Mappings
imap     <Esc> <Nop>
inoremap <C-c> <Esc>
vmap     <Esc> <Nop>
nmap     <C-c> <Nop>
cmap     <C-a> <Home>
cmap     <C-e> <End>

imap <expr> <C-y> <SID>getWord(<SID>prevL())
imap <expr> <C-e> <SID>getWord(<SID>nextL())
imap        <C-]> <C-r>=SuperTab('n')<CR>
imap        <C-l> <C-o>l

map *  <Plug>(asterisk-*)
map #  <Plug>(asterisk-#)
map g* <Plug>(asterisk-g*)
map g# <Plug>(asterisk-g#)

function s:refresh()
    let @/ = ''
    if sneak#is_sneaking()
        call sneak#cancel()
    endif
endfunction

function s:toggleNERDTree()
    " Check whether nerdtree is open
    if (g:NERDTree.GetWinNum() != -1)
        NERDTreeClose
    elseif filereadable(expand('%:p'))
        NERDTreeFind
    else
        NERDTreeCWD
    endif
endfunction

function! CmdAlias(abbr, expansion)
  execute 'cabbr '
      \ . a:abbr
      \ . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "'
      \ . a:expansion
      \ . '" : "'
      \ . a:abbr
      \ . '"<CR>'
endfunction

command! -nargs=+ CmdAlias call CmdAlias(<f-args>)

CmdAlias qq q!

function s:safePaste()
    let ispaste = &paste
    let ismouse = &mouse
    set paste
    set mouse=
    execute 'normal "*p'
    let &paste = ispaste
    let &mouse = ismouse
endfunction

nmap <silent> <Tab>     :bnext<CR>
nmap <silent> <S-Tab>   :bprevious<CR>
nnoremap <silent> <C-l> :call <SID>refresh()<CR><C-l>
nmap <silent> <Leader>a :FSHere<CR>
nmap <silent> <Leader>b :BufstopFast<CR>
nmap <silent> <Leader>e :call <SID>toggleNERDTree()<CR>
nmap <silent> <Leader>f :CtrlP<CR>
nmap          <Leader>g :Ag!<Space>
nmap <silent> <Leader>m :MRU<CR>
nmap <silent> <Leader>p :call <SID>safePaste()<CR>
map  <silent> <Leader>r <Plug>(quickrun)
nmap <silent> <Leader>t :TagbarToggle<CR>
nmap <silent> <Leader>u :GundoToggle<CR>
nmap <silent> <Leader>y :Yanks<CR>
map  <silent> <Leader>/ <plug>NERDCommenterToggle
nmap <silent> ]l :lnext<CR>
nmap <silent> [l :lprev<CR>
nmap f :<c-u>call sneak#wrap('', 1, 0, 1, 1)<CR>
nmap F :<c-u>call sneak#wrap('', 1, 1, 1, 1)<CR>
nmap t :<c-u>call sneak#wrap('', 1, 0, 0, 1)<CR>
nmap T :<c-u>call sneak#wrap('', 1, 1, 0, 1)<CR>
nmap Q <Nop>
nmap Y y$
nmap j gj
vmap j gj
nmap k gk
vmap k gk
