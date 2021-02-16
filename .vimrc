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
highlight CursorLineNR  cterm=bold  ctermbg=none    ctermfg=Grey

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
"   - enable case insensitive search by default, eg:   /text   or   /Text\c
"   - for case sensitive search use:                   /Text   or   /text\C
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hlsearch
set incsearch

set ignorecase
set smartcase

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   - highlight trailing whitespaces and tabs
"   - show tab character and whitespace character
"   - delete all trailing whitespaces by pressing Shift+x or X
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"highlight ExtraWhitespace ctermbg=Black ctermfg=DarkGrey
"match ExtraWhitespace /\s\+$\|\t/
highlight TabCharacter      ctermbg=Black   ctermfg=DarkGrey
highlight ExtraWhitespace   ctermbg=Black   ctermfg=Red
call matchadd('TabCharacter', '\t', 1)
call matchadd('ExtraWhitespace', '\s\+$', 2)

set listchars=tab:›\ ,trail:.
set list

map X :%s/\s\+$//g <CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   - open vertical split on the right and horizontal split below the current
"   - use Ctrl+W to navigate between splits
"   - highlight status line off current split
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitright
set splitbelow

map <C-W> <C-W>w

highlight StatusLine    ctermbg=black   ctermfg=gray
highlight StatusLineNC  ctermbg=black   ctermfg=darkgray

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
