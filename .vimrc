syntax on
" autoread on buffer changed from outside
set autoread
set nocompatible
set wildmode=longest,list,full
set wildmenu

" tabcompletion
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

set dictionary="/usr/dict/words"
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set autoindent cindent smartindent
set mouse=a

" toggling paste with f5
set pastetoggle=<f5>
set incsearch
set hlsearch

" remove highighting on escape press
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[
filetype off

" setting path to include all
set path+=**
set laststatus=2
if !has('gui_running')
  set t_Co=256
endif

nnoremap <C-H> :Hexmode<CR>
inoremap <C-H> <Esc>:Hexmode<CR>
vnoremap <C-H> :<C-U>Hexmode<CR>
" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries 
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

" removing hit ENTER to continue
set shortmess=a

" jumping without no write since last change
set hidden
set title

set foldmethod=manual
" Vundle stuff
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'preservim/nerdtree'
Plugin 'gmarik/vim-markdown'
Plugin 'tpope/vim-surround'

Plugin 'tpope/vim-commentary'
autocmd FileType python setlocal commentstring=#\ %s
au BufNewFile,BUfRead,BufReadPost *.sage set syntax=python

" Plugin 'klen/python-mode'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'tpope/vim-obsession'

" Plugin 'vim-scripts/indentpython.vim'
" Plugin 'vim-syntastic/syntastic'
call vundle#end()
filetype plugin indent on

let mapleader = "," " map leader to comma

function! ToggleLineNumber()
    if v:version > 703
        if (!&relativenumber && !&number)
            set number
        elseif (!&relativenumber && &number)
            set relativenumber
        elseif (&relativenumber && &number)
            set nonumber
        else
            set norelativenumber
        endif
    else 
        set number!
    endif
endfunction

highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn','\%81v',100)

map <leader>r :call ToggleLineNumber()<CR>
set number
set relativenumber
