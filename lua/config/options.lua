-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- Override LazyVim default options
opt.clipboard = '' -- Sync with system clipboard only mess up c d operations
opt.confirm = false -- Confirm on quit is annoying
opt.formatexpr = '' -- Bring back text format based on textwidth
opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = ' ', -- Fill character for diff mode is a waste of attention
  eob = ' ',
}
opt.relativenumber = false -- Relative number is a waste of attention
opt.smoothscroll = false -- Smoothscroll is a huge waste of attention

-- Explicitly set preferred options to avoid upgrading LazyVim mess up things
opt.cmdheight = 2 -- Set the command-line height to 2 lines
opt.cursorline = true -- Enable cursor line highlighting
opt.colorcolumn = '+1' -- Set color column one column beyond the text width
opt.diffopt = 'internal,filler,closeoff,iwhite' -- Set diff options for internal algorithm, filler lines, closing off diff, and ignoring whitespace
opt.fileencodings = 'ucs-bom,utf-8,gb18030,gbk,big5,sjis,latin1' -- Guess file encoding in sequence
opt.fileformats = 'unix,dos' -- Set file formats to recognize Unix and DOS line endings
opt.foldmethod = 'expr' -- Use expression for folding
opt.foldlevelstart = 99 -- Start editing with all folds open
opt.foldexpr = 'nvim_treesitter#foldexpr()' -- Set folding expression to Treesitter
-- opt.guifont = 'FiraCode Nerd Font:h19' -- Set GUI font (affects Neovim GUI clients)
opt.guifont = 'Maple Mono NF CN:h20' -- Set GUI font (affects Neovim GUI clients)
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Override 'ignorecase' when the search pattern contains uppercase letters
opt.list = true -- Show some otherwise invisible characters (e.g., tabs and trailing spaces)
opt.showmode = false -- Do not show mode text (e.g., -- INSERT --) since the statusline often includes it
opt.number = true -- Show line numbers
opt.shada = "!,'1000,<100,f1,h,s10" -- Save more history and save marks in session info
opt.showbreak = '>>' -- Set string to use for wrapped line indication
if vim.fn.has('win32') == 1 then
  opt.shellslash = true -- Use forward slashes for shell commands
end
opt.signcolumn = 'yes' -- Always show the sign column, prevents text shifting
opt.smartindent = true -- Automatically inserts one extra level of indentation in some cases
opt.spell = false -- Disable spell checking
opt.termguicolors = true -- Enable 24-bit RGB colors in the terminal GUI
opt.timeoutlen = 500 -- Need enough timeout for easier use <Esc> started key combinations
opt.undofile = true -- Enable undo file
opt.virtualedit = 'block' -- Allow cursor to move where there is no actual character in visual block mode
opt.visualbell = true -- Use visual bell instead of an audible bell
opt.wildmode = 'list:longest,full' -- Command-line completion behavior

vim.g.lazyvim_cmp = 'nvim-cmp'
vim.g.lazyvim_python_lsp = 'basedpyright'
vim.g.lazyvim_ruby_lsp = 'ruby_lsp'
vim.g.lazyvim_ruby_formatter = 'rubocop'
-- vim.g.do_legacy_filetype = 1
vim.g.snacks_animate = false

-- For Python set this
-- opt.textwidth = 88
