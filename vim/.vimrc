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
Plugin 'VundleVim/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

if !exists('g:vscode')
Plugin 'preservim/nerdtree'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'dense-analysis/ale'
if exists('$SOLARIZED') && $SOLARIZED ==? '1'
    Plugin 'lifepillar/vim-solarized8'
else
    Plugin 'NLKNguyen/papercolor-theme'
endif
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'neovim/nvim-lspconfig'   " LSP configuration for various servers
Plugin 'hrsh7th/nvim-cmp'        " The autocompletion engine
Plugin 'hrsh7th/cmp-nvim-lsp'    " The LSP source for nvim-cmp
Plugin 'saadparwaiz1/cmp_luasnip' " LuaSnip integration with nvim-cmp
Plugin 'L3MON4D3/LuaSnip'        " The snippet engine itself
Plugin 'tpope/vim-commentary'
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
    \         'color00' : ['#ffffff', '255'],
    \       }
    \     }
    \   }
    \ }


    set termguicolors
    if exists('$SOLARIZED') && $SOLARIZED ==? '1'
        set background=light
        colorscheme solarized8
    else
        set background=light
        colorscheme PaperColor
        let g:airline_theme='papercolor'
    endif
    " airline
    let g:airline_section_y = airline#section#create('%{virtualenv#statusline()}')
    if &term =~ 'linux'
        set background=dark
        set t_Co=8
        let g:airline_symbols_ascii = 1
        colorscheme default
    endif

    let g:airline_left_sep = ''
    let g:airline_right_sep = ''
endif

" Indent and stuff
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=0
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
    " Enable ruff as linter
    let g:ale_linters = {
    \   'python': ['ruff'],
    \}

    " Custom ruff fixers (since built-in support varies by ALE version)
    function! RuffCheck(buffer) abort
        return {
        \   'command': 'ruff check --fix --stdin-filename %s',
        \   'read_temporary_file': 0,
        \}
    endfunction

    function! RuffFormat(buffer) abort
        return {
        \   'command': 'ruff format --stdin-filename %s',
        \   'read_temporary_file': 0,
        \}
    endfunction

    let g:ale_fixers = {
    "\   'python': [function('RuffCheck'), function('RuffFormat')],
    \   'python': [function('RuffFormat')],
    \}

    " ALE settings
    let g:ale_fix_on_save = 1
    let g:ale_lint_on_text_changed = 'never'
    let g:ale_lint_on_insert_leave = 1
    let g:ale_python_ruff_executable = 'ruff'

    let NERDTreeShowHidden=1
endif

" clear surch by enter
:nnoremap <silent> <CR> :nohlsearch<CR><CR>

:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>a

set cursorline

if !exists('g:vscode')
autocmd BufWritePre *.json :%!jq --indent 4 .

" Most robust mappings for vim-commentary
nnoremap <C-_> <Plug>Commentary<Space>
xnoremap <C-_> <Plug>Commentary

" Minimal LSP and autocompletion configuration
if has('nvim')
    lua << EOF

    -- ----------------------------------------------------
    -- LSP Setup (for pyright)
    -- ----------------------------------------------------
    local lspconfig = require('lspconfig')

    -- This autocmd sets up buffer-local keymaps for LSP functions
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
            local nmap = function(keys, func, desc)
                if desc then desc = 'LSP: ' .. desc end
                vim.keymap.set('n', keys, func, { buffer = ev.buf, desc = desc })
            end

            -- F2 to rename a variable
            nmap('<F2>', vim.lsp.buf.rename, '[R]ename')
        end,
    })

    -- Configure the pyright language server
    lspconfig.pyright.setup({})

    -- ----------------------------------------------------
    -- Autocompletion Setup (nvim-cmp)
    -- ----------------------------------------------------
    local cmp = require('cmp')

    cmp.setup({
        -- Only use the nvim-lsp source for a minimal setup
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
        }),
        -- Mappings for completion menu
        mapping = cmp.mapping.preset.insert({
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<C-Space>'] = cmp.mapping.complete(),
        }),
        -- You can configure other things here, but this is a minimal setup
        -- For example: a simple border for the completion window
        window = {
            completion = cmp.config.window.bordered(),
        },
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
    })
EOF


endif
endif
