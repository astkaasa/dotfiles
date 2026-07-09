" Minimal Vim config for daily editing.

set nocompatible
filetype plugin indent on
syntax enable

let mapleader = ","

" Basic editing defaults.
set number
set hidden
set backspace=indent,eol,start
set history=1000

" Indentation.
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent

" Wrapped lines should remain readable in prose and config files.
set wrap
set linebreak
if exists('&breakindent')
  set breakindent
endif

" Search.
set ignorecase
set smartcase
set incsearch
set hlsearch

" Command-line completion.
set wildmenu
set wildmode=list:longest
set wildignore+=.git,node_modules,dist,build,tmp,log

" Keep Vim quiet at file boundaries and errors.
set noerrorbells
set novisualbell
" Neovim does not support every legacy terminal option that Vim exposes.
if exists('&t_vb')
  set t_vb=
endif
if exists('&belloff')
  set belloff=all
endif

" Avoid project-local temporary files and file-controlled settings.
set noswapfile
set nobackup
set nomodeline

" Keep undo history outside project directories.
if has('persistent_undo')
  let s:undo_dir = expand('~/.vim/undo')
  silent! call mkdir(s:undo_dir, 'p')
  if isdirectory(s:undo_dir)
    execute 'set undodir=' . fnameescape(s:undo_dir)
    set undofile
  endif
endif

" Use the system clipboard when this Vim build supports it.
if has('clipboard')
  if has('unnamedplus')
    set clipboard=unnamedplus
  else
    set clipboard=unnamed
  endif
endif

" Small convenience mappings.
nnoremap <leader>w :write<CR>
nnoremap <leader>q :quit<CR>
nnoremap <leader>h :nohlsearch<CR>
nnoremap <leader>l :set list!<CR>
