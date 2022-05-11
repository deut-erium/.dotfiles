syntax on
" autoread on buffer changed from outside
set autoread
au Focusgained,BufEnter * checktime

" :W sudo saves the file
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" avoid garbled characters in chinese lang windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim


set nocompatible
" turn on wildmenu and ignore compiled files
set wildmode=longest,list,full
set wildmenu
set wildignore=*.o,*~,*.pyc
if has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" set height of cmd bar
set cmdheight=1

" configure backspace to act the way it should
set backspace=eol,start,indent
set whichwrap+=<,>,h,l


" when searching try to be smart about cases
set ignorecase
set smartcase
" dont redraw when executing macros (performance config)
set lazyredraw

" set magic on for regex
set magic
set tagcase =match
" show matching brackets when text indicator is on them
set showmatch

" how many tenths of a second to blink when matching brackets
set mat=2

" enable syntax highlighting
syntax enable

if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif


if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" set utf8 as standard encoding and en_US as standard lang
set encoding=utf8
" use unix as standard file type
set ffs=unix,dos,mac

if !has('gui_running')
  set t_Co=256
endif

set clipboard=exclude:.*
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
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set autoindent cindent smartindent
set mouse=a

set incsearch
set hlsearch

" remove highighting on escape press
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[
filetype off

autocmd BufRead *.py,*.sage set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufRead *.py,*.sage set nocindent
autocmd BufWritePre *.py,*.sage normal m`:%s/\s\+$//e ``

" setting path to include all
set path+=**

" preventing scan on included files on completion
set complete-=i
set completeopt +=noselect
" options for diffmode
set diffopt +=vertical,foldcolumn:0,indent-heuristic,algorithm:patience
set more

" disabling fsync() to flush a file
set nofsync

set laststatus=2

" removing hit ENTER to continue
set shortmess=a


"remove limit for syntax search on a line column
set synmaxcol=0
" set cursorline to highlight the line with cursor
set cursorline
set sidescroll =5
" keep number of lines above and below
set scrolloff  =6
" 

set splitright
set splitbelow

" jumping without no write since last change
set hidden
set title

set foldmethod=manual
" Vundle stuff
if has('win64') || has("win32")
    set shellslash
    set rtp+=~/vimfiles/bundle/Vundle.vim
    call vundle#begin('~/vimfiles/bundle')
    set bs=2
else
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
endif

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

    Plugin 'wlangstroth/vim-racket'

    " Plugin 'vim-scripts/indentpython.vim'
    Plugin 'vim-syntastic/syntastic'
    " for displaying num search results
    Plugin 'google/vim-searchindex'
    " for usual code alignment stuff
    Plugin 'junegunn/vim-easy-align'

    " Better vim-diffs
    Plugin 'chrisbra/vim-diff-enhanced'

    " color theme
    Plugin 'NLKNguyen/papercolor-theme'

    " . repeat behavior
    Plugin 'tpope/vim-repeat'
    
    " rainbow parenthesis
    Plugin 'frazrepo/vim-rainbow'

    Plugin 'vim-scripts/DrawIt' " ascii drawing vim

    Plugin 'vim-scripts/ZoomWin' " zoom into windows vim
    
    Plugin 'vim-scripts/YankRing.vim' " maintains a list of yanks

    Plugin 'vim-scripts/taglist.vim'

    " vim latex 
    Plugin 'lervag/vimtex'

    " snippets
    Plugin 'sirver/ultisnips'

    Plugin 'jayli/vim-easycomplete'

    Plugin 'prabirshrestha/vim-lsp'

call vundle#end()

set background=dark
colorscheme PaperColor

" ultisnips
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories=[$HOME.'/.dotfiles/snippets/','UltiSnips','vim-snippets']
let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit=$HOME.'/.dotfiles/snippets'


" vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" taglist
let g:Tlist_Use_Right_Window = 1

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_check_on_w = 0
" dont check actively by default
let g:syntastic_mode_map = {'mode':'passive'}


"" Display checker-name for that error-message
let g:syntastic_aggregate_errors = 1

"" I use the brew to install flake8
let g:syntastic_python_checkers=['flake8', 'python3']


filetype plugin indent on

let mapleader = " " " map leader to space



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


highlight ColorColumn ctermbg=Black
call matchadd('ColorColumn','\%81v',100)

" toggling paste with leader ll
nnoremap <leader>pp :set invpaste<CR>
nnoremap <leader>so :source ~/.vimrc<CR>
nnoremap <leader>se :e ~/.vimrc<CR>


nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>r :Rg<CR>
nnoremap <silent> <leader>b :Buffers<CR>
 "file history
nnoremap <silent> <leader>h :History<CR> 
 "command history
nnoremap <silent> <leader>c :History:<CR> 
 "search history
nnoremap <silent> <leader>/ :History/<CR> 
nnoremap <silent> <leader>t :Tags<CR>
 "Lines in loaded buffer
nnoremap <silent> <leader>l :Lines<CR> 
 "delete buffer
nnoremap <silent> <leader>d :bd<CR> 
nnoremap <silent> <leader>sc :SyntasticCheck<CR> 
nnoremap <silent> <leader>st :SyntasticToggleMode<CR> 
nnoremap <silent> <leader>sr :SyntasticReset<CR> 

nnoremap <silent> <leader>ss :Snippets<CR>

nnoremap <silent> <leader>tl :TlistToggle<CR>

" easycomplete 
nnoremap <silent> <leader>ee :EasyCompleteEnable<CR>
" call :EasyCompleteDisable 
nnoremap <silent> <leader>ed :EasyCompleteDisable<CR>
nnoremap <silent> <leader>er :EasyCompleteReference<CR>
nnoremap <silent> <leader>eg :EasyCompleteGotoDefinition<CR>

" lazy
nnoremap <silent> <leader>dp :diffput<CR>
nnoremap <silent> <leader>dg :diffget<CR>
nnoremap <silent> <leader>dd :diffupdate<CR>

function! DisableEasyComplete()
    :EasyCompleteDisable
endfun

function! DisableCompletionOnlyFirstOpen()
    if !exists('b:has_been_entered')
        let b:has_been_entered = 1
        call DisableEasyComplete()
    endif
endfun


au BufEnter * call DisableCompletionOnlyFirstOpen()
au BufNew *.cpp,*.c,*.h :EasyCompleteEnable



map <leader>n :call ToggleLineNumber()<CR>
" set number
" set relativenumber
" set background=dark
" colorscheme PaperColor

" saving backups and keeping workdir clean
set undofile
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

set backup                        " enable backups
set swapfile                      " enable swaps
if has('win64') || has("win32")
    set undodir=$HOME/vimfiles/tmp/undo     " undo files
    set backupdir=$HOME/vimfiles/tmp/backup " backups
    set directory=$HOME/vimfiles/tmp/swap   " swap files
else
    set undodir=$HOME/vimfiles/tmp/undo     " undo files
    set backupdir=$HOME/vimfiles/tmp/backup " backups
    set directory=$HOME/vimfiles/tmp/swap   " swap files
endif

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun!CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.sage :call CleanExtraSpaces()
    autocmd BufRead,BufNewFile *.md,*.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.sage,*.c,*.h,*.cpp setlocal nu
    autocmd BufRead,BufNewFile *.md,*.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.sage,*.c,*.h,*.cpp setlocal relativenumber
endif

nnoremap <C-H> :Hexmode<CR>
inoremap <C-H> <Esc>:Hexmode<CR>
vnoremap <C-H> :<C-U>Hexmode<CR>
" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

if has("cscope")
    " use both cscope and ctag
    set cscopetag

    " check cscope definition before ctags
    set csto=0

    " add any cscope db in curr dir
    if filereadable("cscope.out")
        cs add cscope.out
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    
    " show message when cscope db added
    set cscopeverbose

    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls

    nmap <leader>cs :cs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <leader>cg :cs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <leader>cc :cs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <leader>ct :cs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <leader>ce :cs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <leader>cf :cs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <leader>ci :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <leader>cd :cs find d <C-R>=expand("<cword>")<CR><CR>

endif

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

