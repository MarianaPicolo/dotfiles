syntax on

set noerrorbells
set exrc
set relativenumber
set nu
set nohlsearch
set hidden
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set noshowmode
set termguicolors
set completeopt=menuone,noinsert,noselect
set colorcolumn=80
set signcolumn=yes
set scrolloff=0
set cmdheight=1
set encoding=UTF-8
set laststatus=2
set shortmess+=c

highlight ColorColumn ctermbg=0 guibg=lightgrey

set wildignore+=*build*
set wildignore+=**/coverage/*
set wildignore+=**/.changelog/*
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*

"*******************************************************************
" Plugins

call plug#begin('~/.vim/plugged')

" Theming
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

" Git related
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Autocomplete and indenting
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nathanaelkane/vim-indent-guides'
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'
Plug 'w0rp/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'luochen1990/rainbow'

" Testing
"Plug 'vim-test/vim-test'

" Search and edition
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'terryma/vim-multiple-cursors'
Plug 'mbbill/undotree'
Plug 'scrooloose/nerdtree'

" Language related
Plug 'jremmen/vim-ripgrep'
Plug 'vim-utils/vim-man'

" Wakatime
Plug 'wakatime/vim-wakatime'

call plug#end()

if !has('gui_running')
  set t_Co=256
endif

colorscheme onedark
set background=dark

if executable('rg')
    let g:rg_derive_root='true'
endif

let mapleader = " "
let g:ctrlp_user_command = ['./git', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:netrw_browse_split=2
let g:netrw_banner = 0
let g:ctrlp_use_caching = 0
let g:netrw_winsize = 25
let g:rainbow_active = 1
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ ]
let g:prettier#autoformat = 0
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" JSX & TSX
augroup ReactFiletypes
  autocmd!
  autocmd BufRead,BufNewFile *.jsx set filetype=javascriptreact
  autocmd BufRead,BufNewFile *.tsx set filetype=typescriptreact
augroup END

"*******************************************************************
" Airline

let g:airline_theme='deus'

"*******************************************************************
" Remaps

" Coc
" coc: GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" coc: autocomplete with <tab>
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" coc: Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR> 
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

"*******************************************************************
" fzf ctrl+p

nnoremap <c-p> :FZF<CR>

"*******************************************************************
" NERDTree

" ctrl+b toggles the tree
nnoremap <c-b> :NERDTreeToggle<CR>

let g:NERDTreeGitStatusNodeColorization = 1
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeColorMapCustom = {
    \ "Staged"    : "#0ee375",
    \ "Modified"  : "#d9bf91",
    \ "Renamed"   : "#51C9FC",
    \ "Untracked" : "#FCE77C",
    \ "Unmerged"  : "#FC51E6",
    \ "Dirty"     : "#FFBD61",
    \ "Clean"     : "#87939A",
    \ "Ignored"   : "#808080"
    \ }
let g:NERDTreeIgnore = ['^node_modules$']
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeMinimalUI = 1

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

"*******************************************************************
" UndoTree
nnoremap <c-z> :UndotreeToggle<CR>

"*******************************************************************
" Better use for arrow keys?
 " Arrow keys set up for easy buffer switching
"nnoremap <left> :bprev<cr>
"nnoremap <right> :bnext<cr>
"nnoremap <down> :buffer #<cr>
"nnoremap <up> :buffers<cr>:buffer<space>
 
"*******************************************************************
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

nnoremap <Leader>ps :Rg<SPACE>
