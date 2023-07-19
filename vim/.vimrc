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
Plugin 'tpope/vim-fugitive'
Plugin 'preservim/nerdtree'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'ron89/thesaurus_query.vim'
Plugin 'dense-analysis/ale'
Plugin 'altercation/vim-colors-solarized'
Plugin 'JulioJu/neovim-qt-colors-solarized-truecolor-only'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'jmcantrell/vim-virtualenv'
"Plugin 'utl.vim'
Plugin 'tpope/vim-surround'
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
    "set t_Co=256   " This is may or may not needed.
    set background=dark
    colorscheme solarized
    let g:airline_theme='solarized'

    " airline
    let g:airline_section_y = airline#section#create('%{virtualenv#statusline()}')
endif

" Indent and stuff
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=120
set expandtab
set autoindent
set fileformat=unix

"au BufWrite * :Autoformat
"let g:autoformat_autoindent = 0
"let g:autoformat_retab = 0
"let g:autoformat_remove_trailing_spaces = 0


set encoding=utf-8

if !exists('g:vscode')
"python with virtualenv support
"python3 << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"    project_base_dir = os.environ['VIRTUAL_ENV']
"    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"    exec(open(activate_this).read(), { "__file__": activate_this })
"EOF
    let g:python3_host_prog = '/usr/bin/python3'

    autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
    map <F8> :!node %<CR>
    map <F5> :!firefox %<CR>

    "python linting
    let g:ale_linters = {'python': ['flake8', 'pylint']}

    let g:ale_fixers = {
          \ 'python': ['yapf'],
          \ 'javascript': ['eslint']
          \}
    let g:ale_fix_on_save = 1
    let g:ale_lint_on_save = 1

    function! LinterStatus() abort
      let l:counts = ale#statusline#Count(bufnr(''))

      let l:all_errors = l:counts.error + l:counts.style_error
      let l:all_non_errors = l:counts.total - l:all_errors

      return l:counts.total == 0 ? '✨ all good ✨' : printf(
            \   '😞 %dW %dE',
            \   all_non_errors,
            \   all_errors
            \)
    endfunction


    set statusline=
    set statusline+=%m
    set statusline+=\ %f
    set statusline+=%=
    set statusline+=\ %{LinterStatus()}
    let NERDTreeShowHidden=1
endif

" clear surch by enter
:nnoremap <silent> <CR> :nohlsearch<CR><CR>

:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>a

:set spelllang=de
:hi SpellBad cterm=underline

let g:tq_language=['en', 'de']
nnoremap <Leader>a :ThesaurusQueryReplaceCurrentWord<CR>

vnoremap <silent> <C-k> :s/^/#/<cr>:noh<cr>
vnoremap <silent> <C-u> :s/^#//<cr>:noh<cr>

set cursorline

highlight clear SignColumn
autocmd InsertEnter * highlight Normal ctermbg=0
autocmd InsertEnter * highlight CursorLine ctermbg=8
autocmd InsertLeave * highlight Normal ctermbg=8
autocmd InsertLeave * highlight CursorLine ctermbg=0

autocmd BufWritePre *.json :%!jq --indent 4 .
