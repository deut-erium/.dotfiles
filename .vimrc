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
set redrawtime=10000

" set magic on for regex
set magic
set tagcase =match
" show matching brackets when text indicator is on them
set showmatch

" how many tenths of a second to blink when matching brackets
set mat=2

set timeoutlen=500

" save all marks (f1) for 1000 files
set viminfo='1000,f1

" Resize split when window is resized
au VimResized * :wincmd =

" enable syntax highlighting
syntax enable

if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

set listchars=tab:▸\ ,eol:¬
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59
set list


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

" set clipboard=exclude:.*
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
    Plug 'itchyny/lightline.vim'
    Plug 'preservim/nerdtree'
    Plug 'gmarik/vim-markdown'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'

    Plug 'tpope/vim-commentary'

    " Plug 'klen/python-mode'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'tpope/vim-obsession'

    " Plug 'wlangstroth/vim-racket'

    " Plug 'vim-scripts/indentpython.vim'
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

    Plug 'jayli/vim-easycomplete'

    " Plug 'prabirshrestha/vim-lsp'

    Plug 'rhysd/vim-grammarous'

    Plug 'rust-lang/rust.vim'

    Plug 'vim-scripts/a.vim', { 'for': ['cpp', 'c', 'h'] }

    Plug 'qpkorr/vim-bufkill'

    Plug 'ledesmablt/vim-run'

    Plug 's3rvac/AutoFenc'

    Plug 'preservim/vimux'

call plug#end()

" call vundle#end()


" fzf settings
" prevent rg to search in file names
" https://github.com/junegunn/fzf/wiki/Examples-(vim)

let g:fzf_history_dir = '~/.local/share/fzf-history'
if exists('$TMUX')
      let g:fzf_layout = { 'tmux': '-p90%,60%' }
else
      let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif


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


command! FZFMru call fzf#run({
\ 'source':  reverse(s:all_files()),
\ 'sink':    'edit',
\ 'options': '-m -x +s',
\ 'down':    '40%' })

function! s:all_files()
  return extend(
  \ filter(copy(v:oldfiles),
  \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
  \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
endfunction


function! s:tags_sink(line)
  let parts = split(a:line, '\t\zs')
  let excmd = matchstr(parts[2:], '^.*\ze;"\t')
  execute 'silent e' parts[1][:-2]
  let [magic, &magic] = [&magic, 0]
  execute excmd
  let &magic = magic
endfunction

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

command! Tags call s:tags()


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

command! FZFNeigh call s:fzf_neighbouring_files()


" command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -g '!{**/node_modules/*,**/.git/*,tags}'".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --glob '!{**/tags,**/.git/*,**/.svn/*,**/dist/*,**/cscope.out,**/kits/*,**/Debug/*,**/Release/*,**/x64/*,**/ipch/*,*.pdb,*.ilk}' ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
command! -bang -nargs=* Rgb call fzf#vim#grep("rg --binary --byte-offset --unrestricted ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

command! -bang -nargs=* Rgc call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --glob '{*.h,*.c,*.cpp,*.rc,*.bat,*.vcxproj,*.wixproj,*.filters,*.txt,*.rc,*.py,*.hpp,*.sln,*.ruleset,*.template,*.ini,*.css,*.def,*.inf,*.json,*.ps1,*.html,*.props,*.wxs,*.md,*.xml,*.json}' ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)


" add rainbow parenthesis
let g:rainbow_active = 1
let g:rainbow_guifgs = [
            \ 'brown',
            \ 'darkgray',
            \ 'darkgreen',
            \ 'darkcyan',
            \ 'darkred',
            \ 'darkmagenta',
            \ 'brown',
            \ 'gray',
            \ 'darkmagenta',
            \ 'darkgreen',
            \ 'darkcyan',
            \ 'darkred',
            \ 'red',
            \ ]
let g:rainblow_cterfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

set background=dark
colorscheme PaperColor

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

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_check_on_w = 0
" let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_remove_include_errors = 1
" dont check actively by default
" let g:syntastic_mode_map = {'mode':'passive'}
let g:syntastic_mode_map = {'mode': 'passive',
                            \ 'active_filetypes':['c','cpp'],
                            \ 'passive_filetypes': ['python']}

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
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
nnoremap <leader>yr :YRShow<CR>
nnoremap <leader>?  :split ~/vimbinds<CR>
nnoremap <leader>pp :set invpaste<CR>
nnoremap <leader>so :source ~/.vimrc<CR>
nnoremap <leader>se :e ~/.vimrc<CR>
nnoremap <leader>lc :call LintC()<CR>
nnoremap <leader>lp :call Apep()<CR>


nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>r :Rg<CR>
nnoremap <silent> <leader>rc :Rgc<CR>
nnoremap <silent> <leader>rb :Rgb<CR>
nnoremap <silent> <leader>b :Buffers<CR>
 "file history
nnoremap <silent> <leader>h :History<CR> 
 "command history
nnoremap <silent> <leader>: :History:<CR> 
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

nnoremap <silent> <leader>sl :Snippets<CR>

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

nnoremap <silent> <leader>ge :GrammarousCheck<CR>
nnoremap <silent> <leader>gd :GrammarousReset<CR>
nnoremap <silent> <leader>d :BD<CR>
nnoremap <silent> <leader>j :BB<CR>
nnoremap <silent> <leader>k :BF<CR>

nnoremap <silent> <leader>cj :cnext<CR>
nnoremap <silent> <leader>ck :cprev<CR>
" nnoremap <silent> <leader>vj ]c<CR>:echo DiffCount()<CR>
" nnoremap <silent> <leader>vk [c<CR>:echo DiffCount()<CR>
nnoremap <silent> <leader>x :call ToggleHex()<CR>
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


fu! SaveSess()
    execute 'mksession! '. getcwd(). '/.session.vim'
endfunction

fu! RestoreSess()
if filereadable(getcwd(). '/.session.vim')
    execute 'so '. getcwd(). '/.session.vim'
    if bufexists(1)
        for l in range(1, bufnr('$'))
            if bufwinnr(l) == -1
                exec 'buffer '. l
            endif
        endfor
    endif
endif
endfunction

autocmd VimLeave * call SaveSess()
autocmd VimEnter * nested call RestoreSess()




function! DisableEasyComplete()
    :EasyCompleteDisable
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

