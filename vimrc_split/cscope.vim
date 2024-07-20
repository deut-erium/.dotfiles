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

    if has("autocmd")
        augroup CscopeUpdate
            autocmd!
            autocmd BufWritePost *.c,*.h,*.cpp,*.hpp,*.cc,*.hh silent! exec "!cscope -b"
        augroup END
    endif

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
