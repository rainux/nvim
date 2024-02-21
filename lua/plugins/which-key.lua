-- Helper functions  ---------------------------------------------------------------------------------------------- {{{1
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
--  --------------------------------------------------------------------------------------------------------------- }}}1

local nmode_mappings = {
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
  g = {
    name = 'Git',
    a = {
      c = { ':Gcommit --amend --verbose<CR>', 'Amend Commit Verbose' },
    },
    b = { ':Git blame<CR>', 'Blame' },
    c = { ':Git commit --verbose<CR>', 'Commit Verbose' },
    d = { ':Gvdiff<CR>', 'Vertical Diff' },
    i = { ':Gsplit! diff<CR><C-W>_', 'Split Diff' },
    k = { ':Gvdiff HEAD<CR><C-W>_', 'Vertical Diff HEAD' },
    l = { ':Gllog<CR>', 'Log' },
    e = { ':Gedit<CR>', 'Edit' },
    g = { ':Ggrep<Space>', 'Grep' },
    r = { ':Gread<CR>', 'Read' },
    s = { ':Neogit<CR>', 'Status' },
    w = { ':Gwrite<CR>', 'Write' },
    f = { ':Git difftool<CR>', 'Diff Tool' },
    m = { ':Git mergetool<CR>', 'Merge Tool' },
  },
  l = {
    i = { '<cmd>LspInfo<CR>', 'LSP Info' },
    r = { '<cmd>LspRestart<CR>', 'LSP Restart' },
    I = { '<cmd>LspInstallInfo<CR>', 'LSP Installer Info' },
  },
  n = {
    t = { '<cmd>NvimTreeToggle<CR>', 'Toggle Nvim Tree' },
    f = { '<cmd>NvimTreeFindFile<CR>', 'Nvim Tree Find File' },
  },
  q = {
    t = { '<cmd>tabclose<CR>', 'Close Tab' },
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
    w = { '<cmd>set wrap!<CR>', 'Wrap' },
  },
}

local vmode_mappings = {
  c = {
    name = 'NERDCommenter',
    c = { '<Plug>NERDCommenterComment', 'NERDCommenter Comment' },
    m = { '<Plug>NERDCommenterMinimal', 'NERDCommenter Minimal' },
    n = { '<Plug>NERDCommenterNest', 'NERDCommenter Nest' },
    s = { '<Plug>NERDCommenterSexy', 'NERDCommenter Sexy' },
    u = { '<Plug>NERDCommenterUncomment', 'NERDCommenter Uncomment' },
    ['<Space>'] = { '<Plug>NERDCommenterToggle', 'NERDCommenter Toggle' },
  },
}

local chalk_nmode_mappings = {
  ['zf'] = { '<Plug>Chalk', 'Create fold at operator movement' },
  ['zF'] = { '<Plug>ChalkRange', 'Create fold for specified number of lines' },
  ['Zf'] = { '<Plug>SingleChalk', 'Create single (opening) fold marker at current level or specified count' },
  ['ZF'] = { '<Plug>SingleChalkUp', 'Create single (opening) fold marker at next level or specified count' },
  ['=z'] = { '<Plug>ChalkUp', 'Increment current fold level' },
  ['-z'] = { '<Plug>ChalkDown', 'Decrement current fold level' },
}

local chalk_vmode_mappings = {
  ['zf'] = { '<Plug>Chalk', 'Create fold at visual selection' },
  ['=z'] = { '<Plug>ChalkUp', 'Increment levels in selection' },
  ['-z'] = { '<Plug>ChalkDown', 'Decrement levels in selection' },
}

return {
  -- WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing.
  {
    'folke/which-key.nvim',
    config = function()
      local wk = require('which-key')
      wk.register(nmode_mappings, { mode = 'n', prefix = ',' })
      wk.register(vmode_mappings, { mode = 'v', prefix = ',' })
      wk.register(chalk_nmode_mappings, { mode = 'n' })
      wk.register(chalk_vmode_mappings, { mode = 'v' })
    end,
  },
}

-- vim: set fdm=marker fdl=0 tw=120:
