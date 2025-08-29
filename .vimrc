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
" turn on wildmenu and ignore compiled files
set wildmode=longest,list,full
set wildmenu
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
" set nottyfast
set ttyfast

" Set the idle redraw time to 10 seconds (improves performance)
set redrawtime=10000

" Enable regular expression magic i.e similar rules to grep
set magic

" Match case in tags search
set tagcase=match

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

set list " Enable list chars
set nu
set relativenumber

" provide visual cue for line breaks introduced by word wrap
set showbreak=\\ "

" Set the color for non-text characters
highlight NonText guifg=#4a4a59

" Set the color for special keys
highlight SpecialKey guifg=#4a4a59
set list


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

" tabcompletion
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

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
filetype off


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

" Increase limit for syntax highlighting columns so that syntax highlighting is more accurate 
set synmaxcol=1000

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
" Vundle stuff
" if has('win64') || has("win32")
"     set shellslash
"     set rtp+=~/vimfiles/bundle/Vundle.vim
"     call vundle#begin('~/vimfiles/bundle')
"     set bs=2
" else
"     set rtp+=~/.vim/bundle/Vundle.vim
"     call vundle#begin()
" endif

call plug#begin()
    Plug 'gmarik/Vundle.vim'
    " lightline status bar 
    Plug 'itchyny/lightline.vim'

    " Nerdtree file explorer 
    Plug 'preservim/nerdtree'

    " vim markdown syntax highlighting and tables
    Plug 'godlygeek/tabular'
    Plug 'gmarik/vim-markdown'

    Plug 'tpope/vim-surround'
    " Vim git integration
    Plug 'tpope/vim-fugitive'

    " easy code commenting
    Plug 'tpope/vim-commentary'

    " Plug 'klen/python-mode'
    "
    " Fuzzy finder in vim
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }


    " vim session management
    Plug 'tpope/vim-obsession'

    " Plug 'wlangstroth/vim-racket'

    Plug 'vim-syntastic/syntastic'
    " for displaying num search results
    Plug 'google/vim-searchindex'
    " for usual code alignment stuff
    Plug 'junegunn/vim-easy-align'

    " Better vim-diffs
    Plug 'chrisbra/vim-diff-enhanced'

    " color theme
    Plug 'NLKNguyen/papercolor-theme'

    " . repeat behavior
    Plug 'tpope/vim-repeat'
    
    " rainbow parenthesis
    Plug 'frazrepo/vim-rainbow'

    Plug 'vim-scripts/DrawIt' " ascii drawing vim

    Plug 'vim-scripts/ZoomWin' " zoom into windows vim
    
    Plug 'vim-scripts/YankRing.vim' " maintains a list of yanks

    Plug 'vim-scripts/taglist.vim'

    " vim latex 
    " Plug 'lervag/vimtex'

    " snippets
    Plug 'SirVer/ultisnips'

    " Plug 'jayli/vim-easycomplete'

    " Plug 'prabirshrestha/vim-lsp'

    Plug 'rhysd/vim-grammarous'

    Plug 'rust-lang/rust.vim'

    " Switch to corresponding header/source
    Plug 'vim-scripts/a.vim', { 'for': ['cpp', 'c', 'h'] }

    " Kill a buffer while keeping its window intact
    Plug 'qpkorr/vim-bufkill'

    " Run shell commands directly from vim
    " Plug 'ledesmablt/vim-run'

    " Automatically detect and set file encoding
    Plug 's3rvac/AutoFenc'

    " Vim tmux integration, send commands to tmux directly from vim
    " Display mark positions, multiple marks per line, navigate marks
    Plug 'kshenoy/vim-signature'
    

    "preview markdown
    Plug 'jclsn/glow.vim'

    "enable :Gbrowse hooks fugitive
    Plug 'tpope/vim-rhubarb'

    " tag list (mostly for rust)
    " Plug 'preservim/tagbar'

    Plug 'zhmars/vim-tagbar'

    " syntax highlighting for move
    Plug '0xmovses/move.vim'

    " syntax highlighting for sage
    Plug 'petRUShka/vim-sage'

    Plug 'will133/vim-dirdiff'

    Plug 'junkblocker/patchreview-vim'
call plug#end()

" call vundle#end()


" fzf settings
" prevent rg to search in file names
" https://github.com/junegunn/fzf/wiki/Examples-(vim)

let g:fzf_history_dir = '~/.local/share/fzf-history'
" if exists('$TMUX')
"       let g:fzf_layout = { 'tmux': '-p90%,60%' }
" else
"       let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
" endif


function! s:ag_to_qf(line)
  let parts = split(a:line, ':')
  return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
        \ 'text': join(parts[3:], ':')}
endfunction

function! s:ag_handler(lines)
  if len(a:lines) < 2 | return | endif

  let cmd = get({'ctrl-x': 'split',
               \ 'ctrl-v': 'vertical split',
               \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
  let list = map(a:lines[1:], 's:ag_to_qf(v:val)')

  let first = list[0]
  execute cmd escape(first.filename, ' %#\')
  execute first.lnum
  execute 'normal!' first.col.'|zz'

  if len(list) > 1
    call setqflist(list)
    copen
    wincmd p
  endif
endfunction

command! -nargs=* Ag call fzf#run({
\ 'source':  printf('ag --nogroup --column --color "%s"',
\                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
\ 'sink*':    function('<sid>ag_handler'),
\ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
\            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
\            '--color hl:68,hl+:110',
\ 'down':    '50%'
\ })


" Define a command ':FZFMru' for fuzzy searching in most recently used files
command! FZFMru call fzf#run({
\ 'source':  reverse(s:all_files()),
\ 'sink':    'edit',
\ 'options': '-m -x +s',
\ 'down':    '40%' })

" Function to get a list of all files
function! s:all_files()
  return extend(
  \ filter(copy(v:oldfiles),
  \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
  \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
endfunction

" Function to handle tag search results
function! s:tags_sink(line)
  let parts = split(a:line, '\t\zs')
  let excmd = matchstr(parts[2:], '^.*\ze;"\t')
  execute 'silent e' parts[1][:-2]
  let [magic, &magic] = [&magic, 0]
  execute excmd
  let &magic = magic
endfunction

" Function to perform tag search
function! s:tags()
  if empty(tagfiles())
    echohl WarningMsg
    echom 'Preparing tags'
    echohl None
    call system('ctags -R')
  endif

  call fzf#run({
  \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
  \            '| grep -v -a ^!',
  \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
  \ 'down':    '40%',
  \ 'sink':    function('s:tags_sink')})
endfunction

" Define a command ':Tags' for fuzzy tag searching
command! Tags call s:tags()

" Function to fuzzy search for neighboring files to the current file 
function! s:fzf_neighbouring_files()
  let current_file =expand("%")
  let cwd = fnamemodify(current_file, ':p:h')
  let command = 'ag -g "" -f ' . cwd . ' --depth 0'

  call fzf#run({
        \ 'source': command,
        \ 'sink':   'e',
        \ 'options': '-m -x +s',
        \ 'window':  'enew' })
endfunction

command! FzfTagsCurrWord call fzf#vim#tags(expand('<cword>'))

" Define a command ':FZFNeigh' for fuzzy searching neighboring files
command! FZFNeigh call s:fzf_neighbouring_files()

" Define commands ':Rg', ':Rgb', and ':Rgc' for fuzzy searching with 'rg'
" Rg for searching text files
" Rgb to search even the binary files
" Rgc for c/cpp specific files
" Rgg for current word under cursor
" command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -g '!{**/node_modules/*,**/.git/*,tags}'".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --glob '!{**/tags,**/.git/*,**/.svn/*,**/dist/*,**/cscope.out,**/kits/*,**/Debug/*,**/Release/*,**/x64/*,**/ipch/*,*.pdb,*.ilk}' ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=* Rgb call fzf#vim#grep("rg --binary --byte-offset --unrestricted ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

command! -bang -nargs=* Rgc call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --glob '{*.h,*.c,*.cpp,*.rc,*.bat,*.vcxproj,*.wixproj,*.filters,*.txt,*.rc,*.py,*.hpp,*.sln,*.ruleset,*.template,*.ini,*.css,*.def,*.inf,*.json,*.ps1,*.html,*.props,*.wxs,*.md,*.xml,*.json}' ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)


" add rainbow parenthesis
let g:rainbow_active = 1
let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

" Set the background color to dark
set background=dark
if !empty(findfile('colors/PaperColor.vim', &runtimepath))
        colorscheme PaperColor
endif

" ultisnips
let g:UltiSnipsExpandTrigger = '<leader><tab>'
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
let g:Tlist_WinWidth = 40
let tlist_cpp_settings = 'c++;c:class;f:function'
let tlist_c_settings = 'c;f:function'

" Syntastic settings

" always populate quickfix list with errors and warnings
let g:syntastic_always_populate_loc_list = 1
" Automatic opening of location list when syntastic finds errors or warnings
let g:syntastic_auto_loc_list = 1
" check the file immediately after it is opened
let g:syntastic_check_on_open = 1
" disable checking when a file is written
let g:syntastic_check_on_wq = 0
let g:syntastic_check_on_w = 0
" use a handler function for cpp for repporting errors
let g:syntastic_cpp_check_header = 1
" remove include errors from the location list
let g:syntastic_cpp_remove_include_errors = 1

" dont check actively by default on the filetypes
let g:syntastic_mode_map = {'mode': 'passive',
                            \ 'active_filetypes':[],
                            \ 'passive_filetypes': ['python']}

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
let g:syntastic_python_checkers=['flake8', 'python3']


let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 2



" Lightline settings
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'obsession', 'mode', 'paste'],
      \             [ 'readonly', 'filename', 'modified', 'charvaluehex', 'syntasticstatus'] ]
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B',
      \ },
      \ 'component_function': {
      \   'syntasticstatus': 'SyntasticStatuslineFlag',
      \   'obsession': 'ObsessionStatus',
      \ },
      \ }

" " tagbar settings for rust
let g:rust_use_custom_ctags_defs = 1
let g:tagbar_type_rust = {
  \ 'ctagsbin' : '/usr/bin/ctags',
  \ 'ctagstype' : 'rust',
  \ 'kinds' : [
      \ 'n:modules',
      \ 's:structures:1',
      \ 'i:interfaces',
      \ 'c:implementations',
      \ 'f:functions:1',
      \ 'g:enumerations:1',
      \ 't:type aliases:1:0',
      \ 'v:constants:1:0',
      \ 'M:macros:1',
      \ 'm:fields:1:0',
      \ 'e:enum variants:1:0',
      \ 'P:methods:1',
  \ ],
  \ 'sro': '::',
  \ 'kind2scope' : {
      \ 'n': 'module',
      \ 's': 'struct',
      \ 'i': 'interface',
      \ 'c': 'implementation',
      \ 'f': 'function',
      \ 'g': 'enum',
      \ 't': 'typedef',
      \ 'v': 'variable',
      \ 'M': 'macro',
      \ 'm': 'field',
      \ 'e': 'enumerator',
      \ 'P': 'method',
  \ },
\ }


let g:tagbar_type_move = {
    \ 'ctagstype': 'move',
    \ 'kinds': [
        \ 'f:functions',
        \ 's:structs',
        \ 'c:constants'
    \ ]
\ }

let g:tagbar_type_circom = {
    \ 'ctagstype': 'circom',
    \ 'kinds': [
        \ 'c:components',
        \ 't:templates',
        \ 'f:functions',
        \ 's:signals'
    \ ]
\ }




" vim-run settings
let g:vim_run_command_map = {
  \'python': 'python3.9',
  \'bash': 'bash',
  \}
":Run yourcommand - runs selected command 
" '<,'>RunVisual - run commands from selected lines

"" Display checker-name for that error-message
let g:syntastic_aggregate_errors = 1

"" I use the brew to install flake8
let g:syntastic_python_checkers=['flake8', 'python3']


filetype plugin indent on

let mapleader = " " " map leader to space

function! LintC()
    !indent -bap -bli0 -i4 -l79 -ncs -npcs -npsl -fca -lc79 -fc1 -ts4 -nut %
endfunction 

function! Apep()
    !autopep8 --in-place --aggressive --aggressive %
endfunction


" Functions to show the diff number in vimdiff
function! UpdateDiffHunks()
    setlocal nocursorbind
    setlocal noscrollbind
    let winview = winsaveview() 
    let pos = getpos(".")
    sil exe 'normal! gg'
    let moved = 1
    let hunks = []
    while moved
        let startl = line(".")
        keepjumps sil exe 'normal! ]c'
        let moved = line(".") - startl
        if moved
            call add(hunks,line("."))
        endif
    endwhile
    call winrestview(winview)
    call setpos(".",pos)
    setlocal cursorbind
    setlocal scrollbind
    let g:diff_hunks = hunks
endfunction

function! DiffCount()
    if !exists("g:diff_hunks") 
        call UpdateDiffHunks()
    endif
    let n_hunks = 0
    let curline = line(".")
    for hunkline in g:diff_hunks
        if curline < hunkline
            break
        endif
        let n_hunks += 1
    endfor
    return n_hunks . '/' . len(g:diff_hunks)
endfunction


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


function! ToggleCopyMode()
    if !exists('b:copyToggled')
        let b:listset = &list
        let b:nuset = &number
        let b:relset = &relativenumber
        set nolist
        set nonu
        set norelativenumber
        call ZoomWin()
        let b:copyToggled = 1
    else
        if b:nuset
            set nu
        endif
        if b:listset
            set list
        endif
        if b:relset
            set relativenumber
        endif
        call ZoomWin()
        unlet b:copyToggled
    endif
endfunction

highlight ColorColumn ctermbg=Black
call matchadd('ColorColumn','\%81v',100)

" toggling paste with leader ll
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
" file history
nnoremap <silent> <leader>h :History<CR>
" command history
nnoremap <silent> <leader>: :History:<CR>
" search history
nnoremap <silent> <leader>/ :History/<CR>
nnoremap <silent> <leader>t :Tags<CR>
 "Lines in loaded buffer
nnoremap <silent> <leader>l :Lines<CR> 
 "delete buffer
nnoremap <silent> <leader>d :bd<CR> 
nnoremap <silent> <leader>sc :SyntasticCheck<CR> 
nnoremap <silent> <leader>st :SyntasticToggleMode<CR> 
nnoremap <silent> <leader>sr :SyntasticReset<CR> 

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

function! VimuxSlime()
    call VimuxRunCommand(@v, 0)
endfunction

let g:VimuxPromptString = ": ?"
" let g:VimuxOrientation = "h"

vmap <Leader>vs "vy :call VimuxSlime()<CR>
nnoremap <Leader>vp :VimuxPromptCommand<CR>
nnoremap <Leader>vl :VimuxRunLastCommand<CR>
nnoremap <Leader>vi :VimuxInspectRunner<CR>
nnoremap <Leader>vq :VimuxCloseRunner<CR>
nnoremap <Leader>vz :VimuxZoomRunner<CR>

function! SaveSess()
    let session_dir = getcwd() . '/.vimsessions'
    if !isdirectory(session_dir)
        call mkdir(session_dir, "p")
    endif
    execute 'mksession! ' . session_dir . '/' . expand('%:t') . '.vim'
endfunction

function! RestoreSess()
    if &diff
        return
    endif
    let session_file = getcwd() . '/.vimsessions/' . expand('%:t') . '.vim'
    if filereadable(session_file)
        execute 'source ' . session_file
        if bufexists(1)
            for l in range(1, bufnr('$'))
                if bufwinnr(l) == -1
                    exec 'buffer ' . l
                endif
            endfor
        endif
    endif
    if argc() == 1
        execute 'edit ' . argv()[0]
    endif
endfunction


function! DeleteBufferFromSession(bufname)
    let session_dir = getcwd() . '/.vimsessions'
    let session_file = session_dir . '/' . expand('%:t') . '.vim'
    if filereadable(session_file)
        execute 'source ' . session_file
        let buffer_number = bufnr(a:bufname)
        if buffer_number != -1
            execute 'bdelete ' . buffer_number
        endif
        execute 'mksession! ' . session_file
    endif
endfunction
command! -nargs=? DeleteBuffer call DeleteBufferFromSession(<q-args> != '' ? <q-args> : expand('%:p'))
autocmd VimLeave * call SaveSess()
" autocmd VimEnter * nested call RestoreSess()



fun! SimpleDiffReview()
    " yank everyting
    normal! ggVGy
    " create new split and paste
    vsplit
    enew
    normal! p
    " remove addition lines 
    silent! %s/^+.*\n//g
    " remove leading - from the lines
    silent! %s/^-//g
    diffthis
    wincmd p
    " remove deleted lines from this one
    silent! %s/^-.*\n//g
    " remove leading + from the lines
    silent! %s/^+//g
    diffthis
endfun 

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



map <leader>n :call ToggleLineNumber()<CR>

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
    autocmd BufRead *.py,*.sage set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
    autocmd BufRead *.py,*.sage set nocindent
    autocmd BufWritePre *.py,*.sage normal m`:%s/\s\+$//e ``
    au BufNewFile,BUfRead,BufReadPost *.sage set syntax=python
    au BufNewFile,BUfRead,BufReadPost *.sage setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.sage :call CleanExtraSpaces()
    autocmd BufRead,BufNewFile *.md,*.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.sage,*.c,*.h,*.cpp setlocal nu
    autocmd BufRead,BufNewFile *.md,*.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.sage,*.c,*.h,*.cpp setlocal relativenumber
    au BufEnter * call DisableCompletionOnlyFirstOpen()
endif

" nnoremap <C-H> :Hexmode<CR>
" inoremap <C-H> <Esc>:Hexmode<CR>
" vnoremap <C-H> :<C-U>Hexmode<CR>
" ex command for toggling hex mode - define mapping if desired
" command -bar Hexmode call ToggleHex()

if has("cscope")
    " use both cscope and ctag
    set cscopetag

    " check cscope definition before ctags
    set csto=0

    function! CheckAndAddCscope(databse)
        if !cscope#is_database_added(a:database)
            cs add a:database
            echo "Added cscope database: " . a:database
        endif
    endfunction

    " Find cscope db in project root
    let project_root = fnamemodify(expand('%:p:h'), ':h')
    let cscope_db = project_root . "/cscope.out"
    if filereadable(cscope_db)
        call CheckAndAddCscope(cscope_db)
    " check $CSCOPE_DB environment var
    elseif $CSCOPE_DB != ""
        call CheckAndAddCscope($CSCOPE_DB)
    endif

    " Smarter databse updates (autocmds)

    " if has("autocmd")
    "     augroup CscopeUpdate
    "         autocmd!
    "         autocmd BufWritePost *.c,*.h,*.cpp,*.hpp,*.cc,*.hh silent! exec "!cscope -u"
    "     augroup END
    " endif
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

function! RemoveControl()
    :%s/[[:cntrl:]]//g
endfunction

function! RemoveNonPrint()
    :%s/[^[:print:]]//g
endfunction




" helper function to toggle hex mode
function ToggleHex(onlyhex=0)
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
    if a:onlyhex
        %!xxd -p
    else
        %!xxd
    endif
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    if a:onlyhex
        %!xxd -r -p
    else
        %!xxd -r
    endif
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

