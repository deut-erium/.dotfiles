" Disable filetype detection temporarily
filetype off
" Begin and end of plugin management with 'plug' (similar to Vundle)
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
    " Automatic syntax checking on various actions
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
    
    " rainbow parenthesis, color each pair of parenthesis differently
    Plug 'frazrepo/vim-rainbow'

    Plug 'vim-scripts/DrawIt' " ascii drawing vim

    Plug 'vim-scripts/ZoomWin' " zoom into windows vim
    
    Plug 'vim-scripts/YankRing.vim' " maintains a list of yanks

    Plug 'vim-scripts/taglist.vim'

    " vim latex 
    Plug 'lervag/vimtex'

    " snippets
    Plug 'SirVer/ultisnips'

    Plug 'jayli/vim-easycomplete'

    " grammar checking
    Plug 'rhysd/vim-grammarous'

    Plug 'rust-lang/rust.vim'

    " Switch to corresponding header/source
    Plug 'vim-scripts/a.vim', { 'for': ['cpp', 'c', 'h'] }

    " Kill a buffer while keeping its window intact
    Plug 'qpkorr/vim-bufkill'

    " Run shell commands directly from vim
    Plug 'ledesmablt/vim-run'

    " Automatically detect and set file encoding
    Plug 's3rvac/AutoFenc'

    " Vim tmux integration, send commands to tmux directly from vim
    Plug 'preservim/vimux'

    Plug 'prabirshrestha/vim-lsp'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'

    " Display mark positions, multiple marks per line, navigate marks
    Plug 'kshenoy/vim-signature'

    " multiple version control systems commands
    Plug 'vim-scripts/vcscommand.vim'

    "preview markdown
    Plug 'jclsn/glow.vim'

    "enable :Gbrowse hooks fugitive
    Plug 'tpope/vim-rhubarb'

    " git view
    Plug 'junegunn/gv.vim'

    " tag list (mostly for rust)
    " Plug 'preservim/tagbar'

    Plug 'zhmars/vim-tagbar'

    " syntax highlighting for move
    Plug '0xmovses/move.vim'

    " syntax highlighting for sage
    Plug 'petRUShka/vim-sage'

call plug#end()


" Shutdown the stupid autocomplete pop whenever you type
let g:asyncomplete_auto_popup = 0

" Rainbow parenthesis settings
" Non ugly high contrast colors
let g:rainbow_active = 1
let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

" Set the background color to dark
set background=dark

" Set the color scheme to PaperColor
colorscheme PaperColor

" UltiSnips settings
let g:UltiSnipsExpandTrigger = '<leader><tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories=[$HOME.'/.dotfiles/snippets/','UltiSnips','vim-snippets']
let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit=$HOME.'/.dotfiles/snippets'

" vimtex settings
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" taglist settings
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

let g:syntastic_aggregate_errors = 1

"" I use the brew to install flake8
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


" vim-run settings
let g:vim_run_command_map = {
  \'python': 'python3.9',
  \'bash': 'bash',
  \}
":Run yourcommand - runs selected command 
" '<,'>RunVisual - run commands from selected lines

"" Display checker-name for that error-message

" Enable filetype detection, plugin loading, and indentation
filetype plugin indent on

" Define a function to blame a file at a specific branch
" requires vim fugitive
function! BlameFileBranch(branch, filepath)
    execute 'tabnew | Git blame -w ' . a:branch . ' -- ' . a:filepath
    " remove the other window
    execute 'only' 
endfunction

" Define a function to blame specific lines of a file at a specific branch
function! BlameFileBranchLines(branch, filepath, lines)
    execute 'tabnew | Git blame -w ' . a:branch . ' -- ' . a:filepath
    execute 'only'
endfunction

" Define a command ':BlameBranch' that takes a branch name as an argument and blames the current file at that branch
command! -nargs=1 BlameBranch call BlameFileBranch(<f-args>, expand('%:p'))


