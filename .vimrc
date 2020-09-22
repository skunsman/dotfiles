syntax on
if has('gui_running')
  set background=dark
  colorscheme solarized
"  set guifont=SourceCodeProForPowerline-Regular:h13
  set guifont=VictorMono-Bold:h13
else 
  colorscheme delek
endif

set autoindent " Copy indent from last line when starting new line
set expandtab " Expand tabs to spaces
set shiftwidth=2 "  Number of auto-indent spaces
set smartindent	" Enable smart-indent
set smarttab	" Enable smart-tabs
set softtabstop=2

set incsearch " Highlight dynamically as pattern is typed
set ruler " Show the cursor position
set number " Show line numbers
highlight LineNr term=bold cterm=NONE ctermfg=White ctermbg=DarkGrey gui=NONE guifg=DarkGrey guibg=NONE

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'

Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'wincent/command-t'

Plug 'powerline/powerline-fonts'
Plug 'tpope/vim-repeat'

call plug#end()


" autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd p
"

let mapleader = ","

nnoremap <leader><Tab> <C-w>w
nnoremap <leader>nt :NERDTreeToggle<CR>


