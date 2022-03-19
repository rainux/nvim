lua require('plugins')
lua require('mappings')

color base16-gruvbox-dark-hard

set cmdheight=2
set colorcolumn=+1
set diffopt=internal,filler,closeoff,iwhite
set fileformats=unix,dos
set guifont=FiraCode\ Nerd\ Font:h21
set ignorecase smartcase
set list
set noshowmode
set number
set shada=!,'1000,<100,f1,h,s10
set showbreak=>>
set shellslash
set signcolumn=yes
set smartindent
set termguicolors
set timeoutlen=500
set undofile
set virtualedit=block
set visualbell
set wildmode=list:longest,full

source ~/.config/nvim/key_mappings.vim
