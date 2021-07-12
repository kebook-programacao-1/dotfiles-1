set nocompatible

" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set mouse=a

set hidden

syntax on

let mapleader=','

" Highlight line
set cursorline
hi cursorline cterm=none term=none
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
highlight CursorLine guibg=#303000 ctermbg=234
" End highlight line

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

autocmd Filetype javascript setlocal ts=2 sw=2 
autocmd Filetype vue setlocal ts=2 sw=2
autocmd Filetype yaml setlocal ts=2 sw=2
autocmd Filetype blade setlocal ts=2 sw=2

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Security ==============================

set modelines=0
set nomodeline

" ================ Custom Settings ========================

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'itchyny/lightline.vim'
Plug 'craigemery/vim-autotag'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'vim-vdebug/vdebug'
Plug 'jwalton512/vim-blade'
Plug 'terroo/vim-auto-markdown'
Plug 'kebook-programacao-1/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'posva/vim-vue'
Plug 'jvanja/vim-bootstrap4-snippets'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'APZelos/blamer.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } 
Plug 'junegunn/fzf.vim'

call plug#end()

" enable git blame
let g:blamer_enabled = 1

" fzf
let g:fzf_preview_window = []

let $FZF_DEFAULT_OPTS="--preview-window 'right:60%' --layout reverse --margin=0,0 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

let g:fzf_layout = 
\ { 'window': 
  \ { 'width': 0.98, 'height': 0.7, 'yoffset': 0.94, 'border': 'rounded' } 
\ }

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" python 2 and 3 server
let g:python_host_prog='/usr/bin/python2'
let g:python3_host_prog='/usr/bin/python'

" Extra
colorscheme dracula

set laststatus=2
set confirm

" Import .lvimrc for specific configuration at each project
function SetLocalOptions(fname)
	let dirname = fnamemodify(a:fname, ':p:h')
	while '/' != dirname
		let lvimrc  = dirname . '/.lvimrc'
		if filereadable(lvimrc)
			execute 'source ' . lvimrc
			break
		endif
		let dirname = fnamemodify(dirname, ':p:h:h')
	endwhile
endfunction

au BufNewFile,BufRead * call SetLocalOptions(bufname('%'))

" Xdebug
let g:vdebug_options= {
\    "port" : 9003,
\    "ide_key" : 'PHPSTORM',
\}

" ================ Keybindind and shortcuts ===============

" Copy from clipboard on wayland
nnoremap <C-@> :call system("wl-copy", @")<CR>
xnoremap "+y y:call system("wl-copy", @")<cr>
nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
nnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', '', 'g')<cr>p

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

map <C-s> :w<CR>
map <C-z> :u<CR>
map q :q<CR>
map Q :q!<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
xnoremap <C-c> y:call system("wl-copy", @")<cr>
nnoremap <C-v> :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
nnoremap <C-]> :LspDefinition<CR>
nnoremap <C-LeftMouse> :LspDefinition<CR>
nnoremap <c-p> :Files<cr>
nnoremap <s-m-p> :GFiles<cr>
nnoremap <c-o> :Buffers<cr>
command! -nargs=1 GitFind !git grep -n '<args>'
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
imap <c-space> <Plug>(asyncomplete_force_refresh)

let g:blamer_enabled = 1
let g:vista_executive_for = {
        \ 'blade': 'html-languageserver',
        \ 'html': 'vim_lsp',
        \ }
let g:vista_ignore_kinds = ['Variable']

" Xdebug - PHP
let g:vdebug_options= {
\    "port" : 9003,
\    "ide_key" : 'PHPSTORM',
\}
