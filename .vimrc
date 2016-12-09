set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize

let vundle_path = "$HOME/.vim/bundle/Vundle.vim"

if !empty(glob(vundle_path))
    " echo 'vundle found:' vundle_path
    " set rtp+=~/.vim/bundle/Vundle.vim
    exe 'set rtp+=' . expand(vundle_path)
    call vundle#begin()
    " alternatively, pass a path where Vundle should install plugins
    " call vundle#begin('~/some/path/here')
    " let Vundle manage Vundle, required
    Plugin 'gmarik/Vundle.vim'
    " Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
    "
    " colorschemes
    Plugin 'tomasr/molokai'
    Plugin 'altercation/vim-colors-solarized'

    Plugin 'indentpython.vim'
    Plugin 'scrooloose/nerdtree'
    Plugin 'presenting.vim'
    Plugin 'godlygeek/tabular'

    Plugin 'tpope/vim-surround'
    Plugin 'Align'
    " syntax highlighting
    Plugin 'keith/tmux.vim'
    Plugin 'plasticboy/vim-markdown'
    " syntax checking
    Plugin 'scrooloose/syntastic'
    " Plugin 'Valloric/YouCompleteMe'
    " All of your Plugins must be added before the following line
    call vundle#end()            " required

    " Brief help
    " :PluginList       - lists configured plugins
    " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
    " :PluginSearch foo - searches for foo; append `!` to refresh local cache
    " :PluginClean      - confirms removal of unused plugins; append `!` to Auto-approve removal
    "
    " see :h vundle for more details or wiki for FAQ
    " Put your non-Plugin stuff after this line
endif

filetype plugin indent on    " required
set nocp
filetype plugin on

"""

syntax enable

" as powerline is managed through anaconda, test it exists before adding
" powerline
let anaconda3_path = "$HOME/anaconda3/"

if !empty(glob(anaconda3_path))
    " powerline
    let powerline_path = anaconda3_path . "lib/python3.5/site-packages/powerline/bindings/vim/"
    exe 'set rtp+=' . expand(powerline_path)

    " powerline
    set guifont=Liberation\ Mono\ for\ Powerline\ 12
    let g:Powerline_symbols = 'fancy'

elseif
    echo "anaconda3 path not found at" anaconda3_path
endif


" ui config

set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces
set shiftwidth=4
set shiftround
set autoindent
set number          " show line numbers
filetype indent on  " load filetype-specific indent files
set showmatch       " highlight matching [{()}]
set mouse=a
set ttymouse=xterm
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" set tw=79
set t_Co=256
set nowrap

" Show Whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match  ExtraWhitespace /\s\+$/

" 80th character line coloring
if exists('+colorcolumn')
    set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256
"
" searching
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set cursorline

" folding
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level

"
" Status Line
"
set laststatus=2  " Always display status line.
set showcmd
set ruler

" Vim
let g:indentLine_color_term = 239

"GVim
let g:indentLine_color_gui = '#A4E57E'

" none X terminal
let g:indentLine_color_tty_light = 7 " (default: 4)
let g:indentLine_color_dark = 1 " (default: 2)
let g:indentLine_char = '|'
let g:indentLine_concealcursor = 'vc'
let g:indentLine_conceallevel = 0

" nerdtree settings
" let g:NERDTreeDirArrowExpandable = '▸'
" let g:NERDTreeDirArrowCollapsible = '▾'

set background=dark
let g:solarized_termcolors=256
colorscheme molokai


