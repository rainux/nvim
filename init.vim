lua require('plugins')
lua require('mappings')
lua lvim = { builtin = {} }

color base16-gruvbox-dark-hard

set cmdheight=2
set cursorline
set colorcolumn=+1
set diffopt=internal,filler,closeoff,iwhite
set fileformats=unix,dos
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set guifont=FiraCode\ Nerd\ Font:h19
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

" TODO: Setup tab behavior based on file types
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

autocmd CursorHold * lua vim.diagnostic.open_float()
autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()
autocmd BufWritePre *.go :silent! lua require('go.format').goimport()
autocmd BufEnter *.go :set noexpandtab shiftwidth=4 softtabstop=4 tabstop=4

source ~/.config/nvim/key_mappings.vim
