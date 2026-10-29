set nocompatible

" Basic editor settings
set showcmd
set number
set laststatus=2
set cursorline
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=0
set expandtab
set autoindent
set fileformat=unix
set encoding=utf-8

" Basic keyboard shortcuts
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <silent> <CR> :nohlsearch<CR><CR>
nnoremap <C-s> :write<CR>
inoremap <C-s> <Esc>:write<CR>a
nnoremap <F5> :!firefox %<CR>
nnoremap <F8> :!node %<CR>

" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

if !exists('g:vscode')
  Plugin 'preservim/nerdtree'
  Plugin 'ntpeters/vim-better-whitespace'
  Plugin 'dense-analysis/ale'
  Plugin 'catppuccin/nvim'
  Plugin 'airblade/vim-gitgutter'
  Plugin 'vim-airline/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'
  Plugin 'tpope/vim-commentary'
  Plugin 'keith/swift.vim'
endif

call vundle#end()
filetype plugin indent on

if !exists('g:vscode')
  " NERDTree
  let g:NERDTreeShowHidden = 1
  nnoremap <leader>n :NERDTreeFocus<CR>
  nnoremap <C-n> :NERDTree<CR>
  nnoremap <C-t> :NERDTreeToggle<CR>
  nnoremap <C-f> :NERDTreeFind<CR>

  augroup user-vimrc
    autocmd!
    autocmd StdinReadPre * let s:std_in = 1
    autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif

    autocmd FileType python nnoremap <buffer> <F9> :write<CR>:execute '!python3' shellescape(@%, 1)<CR>
    autocmd FileType c nnoremap <buffer> <F9> :write<CR>:!gcc % -o %< && ./%< <CR>
    autocmd FileType swift nnoremap <buffer> <F9> :write<CR>:execute '!swift' shellescape(@%, 1)<CR>
    autocmd BufWritePre *.json :%!jq --indent 4 .
  augroup END

  " Theme and statusline
  if has('nvim') || has('lua')
    set termguicolors
    set background=light
    colorscheme catppuccin-latte
  endif
  let g:airline_theme = 'catppuccin'
  let g:airline_left_sep = ''
  let g:airline_right_sep = ''

  let g:python3_host_prog = '/usr/bin/python3'

  " ALE
  let g:ale_linters = {
  \   'python': ['ruff'],
  \ }

  function! RuffFormat(buffer) abort
    return {
    \   'command': 'ruff format --stdin-filename %s',
    \   'read_temporary_file': 0,
    \ }
  endfunction

  let g:ale_fixers = {
  \   'python': [function('RuffFormat')],
  \   'swift': ['swiftformat'],
  \ }
  let g:ale_fix_on_save = 1
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_lint_on_insert_leave = 1
  let g:ale_python_ruff_executable = 'ruff'

  " vim-commentary
  nnoremap <C-_> <Plug>Commentary<Space>
  xnoremap <C-_> <Plug>Commentary
endif
