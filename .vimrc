""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   - set dark background and default syntax highlighting
"   - highlight 81st column
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
syntax on

highlight ColorColumn ctermbg=Black
set colorcolumn=81

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   - show line numbers     (to disable :set nonumber)
"   - highlight current line number
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number

set cursorline
set cursorlineopt=number
highlight LineNR        cterm=none  ctermbg=none    ctermfg=DarkGrey
highlight CursorLineNR  cterm=bold  ctermbg=none    ctermfg=White

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   - use 4 spaces long tab character
"   - insert 4 spaces in stead of tab character    (to disable :set noexpandtab)
"   - automatically indent new line based on the current line and file type
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4

set shiftwidth=4
set expandtab

set autoindent
filetype plugin indent on
"set smartindent    " works for c-like files (cannot be conbined with cindent)
"set cindent        " more strict when it comes to syntax

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   - highlight the search text and seach while typing
"   - do not wrap search around the end of file
"   - enable case insensitive search by default, eg:   /text   or   /Text\c
"   - for case sensitive search use:                   /Text   or   /text\C
"   - highlight search text in yellow and text to be replaced in red
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hlsearch
set incsearch
set nowrapscan

set ignorecase
set smartcase

highlight Search        ctermfg=black   ctermbg=yellow
highlight IncSearch     ctermfg=red     ctermbg=white

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   - highlight trailing whitespaces and tabs
"   - show tab character and whitespace character
"   - delete all trailing whitespaces by pressing Shift+x or X
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"highlight ExtraWhitespace ctermbg=Black ctermfg=DarkGrey
"match ExtraWhitespace /\s\+$\|\t/
function! ShowSpacesAndTabs()
    highlight TabCharacter      ctermbg=Black   ctermfg=DarkGrey
    highlight ExtraWhitespace   ctermbg=Black   ctermfg=Red
    call matchadd('TabCharacter', '\t', 1)
    call matchadd('ExtraWhitespace', '\s\+$', 2)
endfun
autocmd BufEnter * :call ShowSpacesAndTabs()
autocmd WinNew   * :call ShowSpacesAndTabs()
autocmd TabNew   * :call ShowSpacesAndTabs()

set listchars=tab:›\ ,trail:.
set list

map X :%s/\s\+$//g <CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   - open vertical split on the right and horizontal split below the current
"   - use Ctrl+W+W or Ctrl+M to navigate between splits
"   - highlight status line off current split
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitright
set splitbelow

map <C-m> <C-W>w
"map <C-n> <C-W>w
"map <C-b> <C-W>W

highlight StatusLine    ctermbg=black   ctermfg=gray
highlight StatusLineNC  ctermbg=black   ctermfg=darkgray
highlight VertSplit     ctermbg=gray    ctermfg=gray

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   - keep 5 lines above and below the cursor while vertical scrolling
"   - disable text wrap     (to enable :set wrap)
"   - scroll 1 column at a time and keep 10 columns before and after cursor
"     while horizontal scrolling
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set scrolloff=5

set nowrap

set sidescroll=1
set sidescrolloff=10

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   - enable moving of a cursor beyod end of the line in visual block mode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set virtualedit=block,insert
set virtualedit=block

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   - configure color highlights for vimdiff
"   - highlight TODOs in red
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight DiffAdd      ctermfg=black   ctermbg=LightGreen
highlight DiffDelete   ctermfg=black   ctermbg=LightRed
highlight DiffChange   ctermfg=black   ctermbg=LightBlue
highlight DiffText     ctermfg=black   ctermbg=Blue

highlight Todo         ctermfg=Red     ctermbg=Black

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   - show function name on the second status line based on the cursor position
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ShowFuncName()
    let l:linenum = line(".")
    if !exists('w:linenum') || w:linenum != l:linenum
        let w:linenum = l:linenum
        let l:funcname = getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bcWn'))
        if l:funcname != ""
            echo ">>>" strpart(l:funcname, 0, winwidth(0)-24)
        else
            echo ""
        endif
    endif
endfun
set laststatus=2
set updatetime=10   " wait for 10ms before CursorHold autocmd event
autocmd CursorHold * :call ShowFuncName()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   - jump to a tag if there is only one matching tag otherwise display a list
"     of matching tags by pressing Ctrl+]
"   - display contents of tag stack by pressing Shift+t or T
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-]> g<C-]>
map T :tags <CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   - jump to the last position when reopening a file
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   - create a backup of the intermediate states of a file, only if '.backup'
"     directory is present in PWD
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if isdirectory(".backup")
    au BufReadPre   * silent !cp % .backup/$(date +\%y\%m\%d\%H\%M\%S)\ o$(echo %:p | sed 's/\//\-/g')
    au BufWritePost * silent !cp % .backup/$(date +\%y\%m\%d\%H\%M\%S)\ w$(echo %:p | sed 's/\//\-/g')
endif
