" fzf settings
" prevent rg to search in file names
" https://github.com/junegunn/fzf/wiki/Examples-(vim)
let g:fzf_history_dir = '~/.local/share/fzf-history'
" if exists('$TMUX')
"       let g:fzf_layout = { 'tmux': '-p90%,60%' }
" else
"       let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
" endif


" Function to handle 'ag' search results to quickfix
function! s:ag_to_qf(line)
  let parts = split(a:line, ':')
  return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
        \ 'text': join(parts[3:], ':')}
endfunction

" Function to handle 'ag' search results in fzf
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

" Define a command ':Ag' for fuzzy searching with 'ag'
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
command! -bang -nargs=* Rgg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --glob '!{**/tags,**/.git/*,**/.svn/*,**/dist/*,**/cscope.out,**/kits/*,**/Debug/*,**/Release/*,**/x64/*,**/ipch/*,*.pdb,*.ilk}' ".shellescape(<q-args>), 1, {'options': '-q '.expand('<cword>')}, <bang>0)

