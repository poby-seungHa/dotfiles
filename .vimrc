" ___       __   ________  ________  ___          ___      ___ ___  _____ ______   ________  ________     
"|\  \     |\  \|\   __  \|\   __  \|\  \        |\  \    /  /|\  \|\   _ \  _   \|\   __  \|\   ____\    
"\ \  \    \ \  \ \  \|\  \ \  \|\ /\ \  \       \ \  \  /  / | \  \ \  \\\__\ \  \ \  \|\  \ \  \___|    
" \ \  \  __\ \  \ \   __  \ \   __  \ \  \       \ \  \/  / / \ \  \ \  \\|__| \  \ \   _  _\ \  \       
"  \ \  \|\__\_\  \ \  \ \  \ \  \|\  \ \  \       \ \    / /   \ \  \ \  \    \ \  \ \  \\  \\ \  \____  
"   \ \____________\ \__\ \__\ \_______\ \__\       \ \__/ /     \ \__\ \__\    \ \__\ \__\\ _\\ \_______\
"    \|____________|\|__|\|__|\|_______|\|__|        \|__|/       \|__|\|__|     \|__|\|__|\|__|\|_______|


filetype off                                       " required by Vundle (re-enabled below)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

"Vim util
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons' "nerd tree folder icons theme
Plug 'vim-airline/vim-airline' "vim mode display
Plug 'vim-airline/vim-airline-themes'
Plug 'terryma/vim-multiple-cursors'
Plug 'ctrlpvim/ctrlp.vim'      "Ctrl + P for search file
Plug 'rking/ag.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'

"Editing utils
Plug 'scrooloose/nerdcommenter' " comment help tool

"vim javascript, jsx
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'w0rp/ale' " eslint

"vim golang
Plug 'fatih/vim-go'

"vim theme color
Plug 'morhetz/gruvbox'

"vim markdown
Plug 'tpope/vim-markdown'

"auto complete
Plug 'ervandew/supertab'

call plug#end()

" ----------------------------------------------------------------------------
" nerdtree
" ----------------------------------------------------------------------------

nmap ,nt :NERDTree<CR>
nmap ,nf :NERDTreeFind<CR>

" ----------------------------------------------------------------------------
" vim-easymotion
" ----------------------------------------------------------------------------
hi link EasyMotionTarget Search
hi link EasyMotionTarget2First Search
hi link EasyMotionTarget2Second Search
hi link EasyMotionShade Comment
let g:EasyMotion_leader_key=','
map ,l <Plug>(easymotion-lineforward)
map ,j <Plug>(easymotion-j)
map ,k <Plug>(easymotion-k)
map ,h <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion"
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1

" ----------------------------------------------------------------------------
" ctrl setting
" ----------------------------------------------------------------------------

set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']       "Ignore in .gitignore
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'                                           "Ignore node_modules

let g:ag_prg="ag --silent --nogroup --case-sensitive"
let g:ag_highlight=1
let g:ag_format="%f:%l:%m"

" ----------------------------------------------------------------------------
"fzf
" ----------------------------------------------------------------------------

nmap <S-F> :Rg<CR>
let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg
                \ --column
                \ --line-number
                \ --no-heading
                \ --color=always
                \ --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--no-color', '--layout=reverse', '--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

" ----------------------------------------------------------------------------
" vim-multiple-cursor
" ----------------------------------------------------------------------------

let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" ----------------------------------------------------------------------------
" for buffer files
" ----------------------------------------------------------------------------

let g:airline#extensions#tabline#enabled = 1              " vim-airline 버퍼 목록 켜기
let g:airline#extensions#tabline#fnamemod = ':t'          " vim-airline 버퍼 목록 파일명만 출력
let g:airline#extensions#tabline#buffer_nr_show = 1       " buffer number를 보여준다
let g:airline#extensions#tabline#buffer_nr_format = '%s:' " buffer number format
let g:airline_theme='wombat'

nnoremap <leader>t :enew<Enter>         " 새로운 버퍼를 연다
nnoremap <leader>q :bp<CR>
nnoremap <leader>w :bn<CR>
nnoremap <leader>x :bp <BAR> bd #<Enter> " 현재 버퍼를 닫고 이전 버퍼로 이동

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible                " be iMproved, required
set history=50                  " How many lines of history to remember
set confirm                     " Ask for confirmation in some situations (:q)
set ignorecase smartcase        " case insensitive search, except when mixing cases
set modeline                    " we allow modelines in textfiles to set vim settings
set hidden                      " allows to change buffer without saving
set mouse=a                     " enable mouse in all modes
set noerrorbells                " don't make noise
set novisualbell                " don't blink
set t_Co=256                    " Enable 256 color mode
set exrc                        " Scan working dir for .vimrc
set showcmd
set title
set noswapfile                  " no back up file

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text Formatting/Tab settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set formatoptions=tcrqn         " autowrap and comments (see :h 'fo-table)
set autoindent smartindent      " keep indent on next line and make BS work with indenting
set wrap                        " wrap lines that exceed screen
set tabstop=2
set softtabstop=2
set shiftwidth=2
set sw=2
set ts=2
set expandtab
"set textwidth=0                " text witdh column number
set smarttab                    " Make Tab work fine with spaces
set ai                          " Auto indent
set ci                          " Line Break Auto indent
set showmatch                   " show matching brackets
set matchtime=5                 " tenths of a second to blink matching brackets
set hlsearch                    " highlight search phrase matches (reset with :noh)
set incsearch                   " do highlight as you type you search phrase
set list                        " show tabs, trailings spaces, ...
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<

" using tab, shift + tab key for indent as like other ide tools
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

vmap '' :w ! pbcopy<CR><CR>

let NERDSpaceDelims=1 "commnet after space

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set wildmenu                    " Show suggestions on TAB for some commands
set ruler                       " Always show current positions along the bottom
set cmdheight=1                 " the command bar is 1 high
set number                      " turn on line numbers
set lazyredraw                  " do not redraw while running macros (much faster)
set backspace=indent,eol,start  " make backspace work normal
set whichwrap+=<,>,h,l          " make cursor keys and h,l wrap over line endings
set report=0                    " always report how many lines where changed
set fillchars=vert:\ ,stl:\ ,stlnc:\    " make the splitters between windows be blank
set laststatus=2                " always show the status line
set scrolloff=10                " Start scrolling this number of lines from top/bottom
set cursorline
set cursorcolumn

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Navigating between windows
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <Space> :noh<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ESlint setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let b:ale_fixers = ['eslint']
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set encoding=utf-8              " Let Vim use utf-8 internally
set fileencoding=utf-8          " Default for new files
set termencoding=utf-8          " Terminal encoding
set fileformats=unix,dos,mac    " support all three, in this order
set fileformat=unix             " default file format
set fencs=utf-8,euc-kr          " auto file type check

filetype plugin indent on    " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax Highlighting
if has("syntax")
    syntax on
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" language setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" go
let g:go_fmt_command = "goimports"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight ExtraWhitespace ctermbg=red guibg=red
let g:SuperTabDefaultCompletionType = "context"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim theme, Color Scheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
colorscheme gruvbox


