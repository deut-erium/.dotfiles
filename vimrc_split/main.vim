" Set the encoding for the script to UTF-8
scriptencoding utf-8

" Automatically read a file when it is changed outside of Vim
set autoread

" Check if the buffer has been modified externally when regaining focus or entering the buffer
if has("autocmd")
    au Focusgained,BufEnter * checktime
endif


" Define a command ':W' that saves the current file with sudo privileges
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Set the language environment to English to avoid character encoding issues on Windows
let $LANG='en'
set langmenu=en
" remove and repopulate unnecessary menus
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Disable compatibility with Vi
set nocompatible

" Configure wildmenu completion: show the longest common prefix, a list of matches, and the full match
set wildmode=longest,list,full
set wildmenu

" Ignore these file patterns for wildmenu completion
set wildignore=*.o,*~,*.pyc
if has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Set the height of the command bar to one line
set cmdheight=1

" Configure backspace to delete to the beginning of the line, start of insert, and indentation
set backspace=eol,start,indent

" Enable wrapping for <, >, h, and l motions
" i.e cursor moves to next/prev line when arrow is pressed at end
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" Enable smart case: ignore case if the search pattern is all lowercase, otherwise respect case
set smartcase

" Disable redrawing while executing macros
set lazyredraw

" Optimize vim when running in terminal env by aggressive scrolling and disabling semantic lienwrap
set nottyfast

" Set the idle redraw time to 10 seconds (improves performance)
set redrawtime=10000

" Enable regular expression magic i.e similar rules to grep
set magic

" Match case in tags search
set tagcase =match

" highlight matching brackets
set showmatch

" Set the duration for matching bracket blinking to 0.2 seconds
set mat=2

" Set the timeout for key codes to 0.5 seconds
set timeoutlen=500

" Save up to 1000 file marks in the viminfo file for last 50 files
set viminfo='1000,f50

" Automatically resize splits when the window is resized
au VimResized * :wincmd =

" Enable syntax highlighting while preserving custom syntax settings
syntax enable


" " Set the terminal to 256 colors if it's gnome-terminal or tmux-256color
if $COLORTERM == 'gnome-terminal' || $COLORTERM == 'tmux-256color'
    set t_Co=256
endif

" Configure listchars for tabs and end-of-line characters
" represent tab as ~, end of line as -, trailing spaces as _
" 
set listchars=tab:>\ ,eol:_,trail:.,nbsp:+,precedes:<,extends:>

" provide visual cue for line breaks introduced by word wrap
set showbreak=\\ "

" Set the color for non-text characters
highlight NonText guifg=#4a4a59

" Set the color for special keys
highlight SpecialKey guifg=#4a4a59

" Enable GUI options if Vim is running in a GUI
" Disable toolbar and scrollbar
" show the modified status and filename in tab
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set the default encoding to UTF-8
set encoding=utf8

" Use Unix file format by default
set ffs=unix,dos,mac

" Set the terminal to 256 colors if not running in a GUI
if !has('gui_running')
  set t_Co=256
endif

" Use the system clipboard
set clipboard=unnamedplus


" Set the dictionary file for spell checking
set dictionary="/usr/dict/words"

" Configure tab and indentation settings
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set autoindent cindent smartindent

" Enable mouse support
set mouse=a

" enable mouse to drag splits inside tmux
set ttymouse=xterm2

" Enable incremental search
set incsearch

" Highlight search results
set hlsearch

" Clear search highlighting on <Esc>
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[


" Add all directories to the path for finding files
" toh help search 
set path+=**

" Disable completion for included files (to prevent slow recursive scanning of
" irrelevant files
set complete-=i

" Disable automatic selection in completion menu
set completeopt +=noselect

" Configure diff mode options
" vertical for side by side
" set width of foldcolumn to 0
" displaying differences in indentation levels even when original files dont contain explicit indentation info
" patience minimize the number of edits required to transform one file to another
set diffopt +=vertical,foldcolumn:0,indent-heuristic,algorithm:patience

" Enable more screen for commands exceeding screen height
set more

" Disable fsync to flush writes while saving to speed up
set nofsync

" Show the last two commands in the status line
set laststatus=2

" Disable prompts for short messages
set shortmess=a

" Remove the limit for syntax highlighting columns so that syntax highlighting is more accurate 
set synmaxcol=0

" Highlight the current line
set cursorline

" Set the number of columns to scroll horizontally when cursor moves off screen
set sidescroll =5

" Set the number of lines to keep above and below the cursor
set scrolloff  =6

" Open splits to the right and below
set splitright
set splitbelow

" Hide buffers instead of unloading them
set hidden

" Display the window title
set title

" Set the foldmethod to manual ie let me fold myself
set foldmethod=manual


" Set the leader key to space
let mapleader = " "


" Highlight the 81st column to give an indication of line length limit
highlight ColorColumn ctermbg=Black
call matchadd('ColorColumn','\%81v',100)

" Key mappings
"" Toggle copy mode
nnoremap <leader>yy :call ToggleCopyMode()<CR> 
" Show yank history
nnoremap <leader>yr :YRShow<CR> 
" Open vimbinds file
nnoremap <leader>?  :split ~/vimbinds<CR> 
" Toggle paste mode
nnoremap <leader>pp :set invpaste<CR> 
" Source vimrc
nnoremap <leader>so :source ~/.vimrc<CR> 
" Edit vimrc
nnoremap <leader>se :e ~/.vimrc<CR> 
" Run indent on C code
nnoremap <leader>lc :call LintC()<CR> 
" Run autopep8 on Python code
nnoremap <leader>lp :call Apep()<CR> 


" Go to definition
nnoremap <leader>ld :LspDefinition<CR> 
" Find references
nnoremap <leader>lr :LspReferences<CR> 

" Fuzzy search files
nnoremap <silent> <leader>f :Files<CR> 
" Fuzzy search with rg
nnoremap <silent> <leader>r :Rg<CR> 
" Fuzzy search C/C++ files with rg
nnoremap <silent> <leader>rc :Rgc<CR> 
" Fuzzy search binary files with rg
nnoremap <silent> <leader>rb :Rgb<CR> 

" Search current word under cursor
nnoremap <silent> <leader>rg :Rgg<CR> 

" Search recent searches
nnoremap <silent> <leader>rr :FZFMru<CR> 

" fuzzy search in neighbouring file
nnoremap <silent> <leader>rn :FZFNeigh<CR>


" Fuzzy search buffers
nnoremap <silent> <leader>b :Buffers<CR> 

" File history
nnoremap <silent> <leader>h :History<CR> 
" Command history
nnoremap <silent> <leader>: :History:<CR> 
" Search history
nnoremap <silent> <leader>/ :History/<CR> 

 " Fuzzy search tags
nnoremap <silent> <leader>t :Tags<CR>  

" current tag under cursor
nnoremap <silent> <leader>tg :FzfTagsCurrWord<CR>  

" Fuzzy search lines in current buffer
nnoremap <silent> <leader>l :Lines<CR> 
" Delete buffer
nnoremap <silent> <leader>d :bd<CR> 




" Run Syntastic check
nnoremap <silent> <leader>sc :SyntasticCheck<CR> 
" Toggle Syntastic mode
nnoremap <silent> <leader>st :SyntasticToggleMode<CR> 
" Reset Syntastic
nnoremap <silent> <leader>sr :SyntasticReset<CR> 

" Fuzzy search snippets
nnoremap <silent> <leader>sl :Snippets<CR> 

" Toggle taglist
nnoremap <silent> <leader>tl :TlistToggle<CR> 
" Toggle Taglist
nnoremap <silent> <leader>tb :TagbarToggle<CR>



" easycomplete 
"" Enable EasyComplete
nnoremap <silent> <leader>ee :EasyCompleteEnable<CR> 

" call :EasyCompleteDisable 
"" Disable EasyComplete
nnoremap <silent> <leader>ed :EasyCompleteDisable<CR> 
" Find references with EasyComplete
nnoremap <silent> <leader>er :EasyCompleteReference<CR> 
" Go to definition with EasyComplete
nnoremap <silent> <leader>eg :EasyCompleteGotoDefinition<CR> 

" lazy

" Put diff changes
nnoremap <silent> <leader>dp :diffput<CR> 
" Get diff changes
nnoremap <silent> <leader>dg :diffget<CR> 
" Update diff
nnoremap <silent> <leader>dd :diffupdate<CR> 

" Get local diff changes
nnoremap <silent> <leader>dgl :diffget LOCAL<CR> 
" Get remote diff changes
nnoremap <silent> <leader>dgr :diffget REMOTE<CR> 
" Get base diff changes
nnoremap <silent> <leader>dgb :diffget BASE<CR> 

" Search for merge conflicts
nnoremap <silent> <leader>nc /<<<<<<< <CR> 
" Run Grammarous check
nnoremap <silent> <leader>ge :GrammarousCheck<CR> 
" Reset Grammarous
nnoremap <silent> <leader>gd :GrammarousReset<CR> 
" Delete buffer
nnoremap <silent> <leader>d :BD<CR> 
" Switch to previous buffer
nnoremap <silent> <leader>j :BB<CR> 
" Switch to next buffer
nnoremap <silent> <leader>k :BF<CR> 
" Jump to next error
nnoremap <silent> <leader>cj :cnext<CR> 
" Jump to previous error
nnoremap <silent> <leader>ck :cprev<CR> 
" nnoremap <silent> <leader>vj ]c<CR>:echo DiffCount()<CR>
" nnoremap <silent> <leader>vk [c<CR>:echo DiffCount()<CR>
"" Toggle hex mode
nnoremap <silent> <leader>x :call ToggleHex()<CR> 
" Toggle hex mode (only hex)
nnoremap <silent> <leader>xx :call ToggleHex(1)<CR> 

" Vimux settings
function! VimuxSlime()
    call VimuxRunCommand(@v, 0)
endfunction

let g:VimuxPromptString = ": ?"

vmap <Leader>vs "vy :call VimuxSlime()<CR>
nnoremap <Leader>vp :VimuxPromptCommand<CR>
nnoremap <Leader>vl :VimuxRunLastCommand<CR>
nnoremap <Leader>vi :VimuxInspectRunner<CR>
nnoremap <Leader>vq :VimuxCloseRunner<CR>
nnoremap <Leader>vz :VimuxZoomRunner<CR>



set clipboard=unnamedplus
if system('uname -a | egrep [Mm]icrosoft') != ''
 let g:lastyank = 'y'
 if executable('win32yank.exe')
    let g:copy = 'win32yank.exe -i --crlf'
    let g:paste = 'win32yank.exe -o --lf'
 elseif exists('$DISPLAY') && executable('xclip')
    let g:copy = 'xclip -i -selection clipboard'
    let g:paste = 'xclip -o -selection clipboard'
 else
    let g:copy = 'clip.exe'
    let g:paste = 'powershell.exe Get-Clipboard'
 endif
 augroup myYank
    autocmd!
    autocmd TextYankPost * if v:event.operator == 'y' | call system(g:copy, @") | let g:lastyank='y' | else | let g:lastyank='' | endif
 augroup END
 function! Paste(mode)
    if g:lastyank == 'y'
     let @" = system(g:paste)
    endif
    return a:mode
 endfunction
 " map <expr> p Paste('p')
 " map <expr> P Paste('P')
 func! GetSelectedText()
    normal gv"xy
    let result = getreg("x")
    return result
 endfunc
 noremap <leader>c :call system(g:copy, GetSelectedText())<CR>
 " noremap <leader>x :call system(g:copy, GetSelectedText())<CR>gvx
endif

" Set line numbers, relative line numbers, and color scheme
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


" Autocommands
if has("autocmd")
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.sage :call CleanExtraSpaces()
    autocmd BufRead,BufNewFile *.md,*.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.sage,*.c,*.h,*.cpp setlocal nu
    autocmd BufRead,BufNewFile *.md,*.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.sage,*.c,*.h,*.cpp setlocal relativenumber
    au BufEnter * call DisableCompletionOnlyFirstOpen()
endif

" Cscope settings


" Define a function to run the 'indent' command on C code for linting
" dependency on indent
function! LintC()
    !indent -bap -bli0 -i4 -l79 -ncs -npcs -npsl -fca -lc79 -fc1 -ts4 -nut %
endfunction

" Define a function to run 'autopep8' on Python code
" dependency on autopep8
function! Apep()
    !autopep8 --in-place --aggressive --aggressive %
endfunction


" EasyComplete settings
function! DisableEasyComplete()
    if exists(":EasyCompleteDisable")
    :EasyCompleteDisable
    endif
endfun

function! DisableCompletionOnlyFirstOpen()
    if !exists('b:has_been_entered')
        let b:has_been_entered = 1
        call DisableEasyComplete()
    endif
endfun

" Function to source a file only if it exists
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction


call SourceIfExists("~/.dotfiles/vimrc_split/user_functions.vim")
call SourceIfExists("~/.dotfiles/vimrc_split/google_plugins.vim")
call SourceIfExists("~/.dotfiles/vimrc_split/cscope.vim")
call SourceIfExists("~/.dotfiles/vimrc_split/plugins.vim")
if exists(':FZF')
    call SourceIfExists("~/.dotfiles/vimrc_split/fzf_settings.vim")
endif
