local wk = require('which-key')

-- Helper functions  .............................................................................................. {{{1
local function toggle_columns()
  if vim.o.number then
    vim.o.colorcolumn = '0'
    vim.o.number = false
    vim.o.signcolumn = 'no'
    print('Collumns disabled')
  else
    vim.o.colorcolumn = '+1'
    vim.o.number = true
    vim.o.signcolumn = 'yes'
    print('Collumns enabled')
  end
end
-- ................................................................................................................ }}}1

wk.register({
  c = {
    name = 'Convenient Commands',
    c = { '<Plug>NERDCommenterComment', 'NERDCommenter Comment' },
    m = { '<Plug>NERDCommenterMinimal', 'NERDCommenter Minimal' },
    n = { '<Plug>NERDCommenterNest', 'NERDCommenter Nest' },
    s = { '<Plug>NERDCommenterSexy', 'NERDCommenter Sexy' },
    u = { '<Plug>NERDCommenterUncomment', 'NERDCommenter Uncomment' },
    ['<Space>'] = { '<Plug>NERDCommenterToggle', 'NERDCommenter Toggle' },

    t = { '<cmd>Telescope<CR>', 'Telescope' },
    b = { '<cmd>Telescope buffers<CR>', 'Telescope Buffers' },
    f = { '<cmd>Telescope find_files<CR>', 'Find Files' },
    g = { '<cmd>Telescope live_grep<CR>', 'Telescope Live Grep' },
    h = { '<cmd>Telescope help_tags<CR>', 'Telescope Help Tags' },
    k = { '<cmd>Telescope keymaps<CR>', 'Telescope Keymaps' },
    l = { '<cmd>Telescope colorscheme<CR>', 'Telescope Color Scheme' },
    r = { '<cmd>Telescope oldfiles<CR>', 'Open Recent File' },
  },
  l = {
    i = { '<cmd>LspInfo<CR>', 'LSP Info' },
    I = { '<cmd>LspInstallInfo<CR>', 'LSP Installer Info' },
  },
  n = {
    t = { '<cmd>NvimTreeToggle<CR>', 'Toggle Nvim Tree' },
    f = { '<cmd>NvimTreeFindFile<CR>', 'Nvim Tree Find File' },
  },
  r = {
    g = { '<cmd>execute "Rg " . input("Rg search for pattern: ", "<C-R><C-W>")<CR>', 'Rg Search' },
  },
  t = {
    name = 'Toggles',
    a = { '<cmd>ALEToggle<CR>', 'ALE Linting' },
    c = { toggle_columns, 'Columns' },
    h = { '<cmd>set hlsearch!<CR>', 'Highlight Search' },
    i = { '<cmd>IndentBlanklineToggle<CR>', 'Indent Blankline' },
    l = { '<cmd>TagbarToggle<CR>', 'Tagbar' },
    o = { '<cmd>SymbolsOutline<CR>', 'Symbol Outline' },
    s = { '<cmd>set spell!<CR>', 'Spell Check' },
  },
}, { mode = 'n', prefix = ',' })

wk.register({
  c = {
    name = 'NERDCommenter',
    c = { '<Plug>NERDCommenterComment', 'NERDCommenter Comment' },
    m = { '<Plug>NERDCommenterMinimal', 'NERDCommenter Minimal' },
    n = { '<Plug>NERDCommenterNest', 'NERDCommenter Nest' },
    s = { '<Plug>NERDCommenterSexy', 'NERDCommenter Sexy' },
    u = { '<Plug>NERDCommenterUncomment', 'NERDCommenter Uncomment' },
    ['<Space>'] = { '<Plug>NERDCommenterToggle', 'NERDCommenter Toggle' },
  },
}, { mode = 'v', prefix = ',' })

-- vim: set fdm=marker fdl=0 tw=120:
