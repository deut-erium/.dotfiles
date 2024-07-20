
" Helper functions
function! RemoveControl()
    :%s/[[:cntrl:]]//g
endfunction

function! RemoveNonPrint()
    :%s/[^[:print:]]//g
endfunction

" Function to toggle hex mode
" helper function to toggle hex mode
function! ToggleHex(onlyhex=0)
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


" Define a function for tab completion
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction

" Map <Tab> to trigger tab completion or normal tab behavior
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

" Define functions for diff hunks counting
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

" Define a function to toggle line number modes
" linenumbers and relativenumbers
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

" Toggle line numbers
map <leader>n :call ToggleLineNumber()<CR>

" Define a function to toggle copy mode
" Stupid implementation to just zoom on the current window to copy easily from the terminal
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

" Session management functions
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

" Delete trailing spaces
fun!CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
