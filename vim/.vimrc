set showcmd

set number
set laststatus=2

if !exists('g:vscode')
    " Nerdtree
    nnoremap <leader>n :NERDTreeFocus<CR>
    nnoremap <C-n> :NERDTree<CR>
    nnoremap <C-t> :NERDTreeToggle<CR>
    nnoremap <C-f> :NERDTreeFind<CR>
    " Start NERDTree, unless a file or session is specified, eg. vim -S session_file.vim.
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif
endif

" Vundle
set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

if !exists('g:vscode')
Plugin 'davidhalter/jedi-vim'
Plugin 'preservim/nerdtree'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'dense-analysis/ale'
"Plugin 'craftzdog/solarized-osaka.nvim'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'jmcantrell/vim-virtualenv'
"Plugin 'utl.vim'
Plugin 'tpope/vim-surround'
Plugin 'bfontaine/redcode.vim'
endif

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

if !exists('g:vscode')
    "split navigations
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>

    " Color theme
    let g:PaperColor_Theme_Options = {
    \   'theme': {
    \     'default.light': {
    \       'override' : {
    "\         'color00' : ['#ffffff', '255'],
    \       }
    \     }
    \   }
    \ }


    set termguicolors
    set background=light
    "colorscheme solarized-osaka
    colorscheme PaperColor
    let g:airline_theme='papercolor'

    " airline
    let g:airline_section_y = airline#section#create('%{virtualenv#statusline()}')
    if &term =~ 'linux'
        set background=dark
        set t_Co=8
        let g:airline_symbols_ascii = 1
        colorscheme default
    endif
endif

" Indent and stuff
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=120
set expandtab
set autoindent
set fileformat=unix


set encoding=utf-8

if !exists('g:vscode')
    let g:python3_host_prog = '/usr/bin/python3'

    autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
    autocmd FileType c map <F9> :w<CR>:!gcc % -o %< && ./%< <CR>


    map <F8> :!node %<CR>
    map <F5> :!firefox %<CR>

    "python linting
    let g:ale_linters = {'python': ['flake8']}

    let g:ale_fixers = {
          \ 'python': ['autopep8'],
          \ 'javascript': ['eslint']
          \}
    let g:ale_fix_on_save = 1
    let g:ale_lint_on_save = 1

    let NERDTreeShowHidden=1
endif

" clear surch by enter
:nnoremap <silent> <CR> :nohlsearch<CR><CR>

:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>a

set cursorline

autocmd BufWritePre *.json :%!jq --indent 4 .

