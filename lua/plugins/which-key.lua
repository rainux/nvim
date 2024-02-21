-- Helper functions  ---------------------------------------------------------------------------------------------- {{{2
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

local function substitute_current_word()
  local current_word = vim.fn.expand('<cword>')
  current_word = vim.fn.escape(current_word, '/\\')
  -- Prepare the substitution command as a string
  local command = ':%s/' .. current_word .. '/'
  -- Use feedkeys to input the command and wait for the user to enter the replacement
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(command, true, false, true), 'n', false)
end
--  --------------------------------------------------------------------------------------------------------------- }}}2

local primary_nmappings = {
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
      c = { ':Git commit --amend --verbose<CR>', 'Amend Commit Verbose' },
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

  -- Historical conventions  -------------------------------------------------------------------------------------- {{{1
  ['*'] = { substitute_current_word, 'Substitute current word under the cursor' },

  ['cd'] = { ':lcd %:p:h<CR>', 'Change buffer directory to parent dir of current file' },

  ['sr'] = { ':SCCompileRun<CR>', 'Compile and Run with SingleCompile' },
  ['sc'] = { ':SCCompile<CR>', 'Compile with SingleCompile' },

  ['cw'] = { ':cwindow<CR>', 'Open quickfix window' },
  ['cq'] = { ':cclose<CR>', 'Close quickfix window' },

  ['lw'] = { ':lwindow<CR>', 'Open location window' },
  ['lq'] = { ':lclose<CR>', 'Close location window' },

  [','] = { ':cc<CR>', 'Jump to current error in quickfix list' },
  ['.'] = { ':cnext<CR>', 'Jump to next error in quickfix list' },
  ['m'] = { ':cNext<CR>', 'Jump to prev error in quickfix list' },

  ['<'] = { ':ll<CR>', 'Jump to current error in location list' },
  ['>'] = { ':lnext<CR>', 'Jump to next error in location list' },
  ['M'] = { ':lNext<CR>', 'Jump to prev error in location list' },

  ['ff'] = { ':set ff=unix<CR>:%!fromdos<CR>gg=G:%s/\\s\\+$//ge<CR>', 'Format code' },
  ['fc'] = { ':set ff=unix<CR>:%!fromdos<CR>:%s/\\s\\+$//ge<CR>', 'Clean code' },
  --  ------------------------------------------------------------------------------------------------------------- }}}1
}

local primary_vmappings = {
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

local secondary_nmappings = {
  ['ftu'] = { ':set fenc=utf8<CR>:w<CR>', 'Convert buffer to UTF-8 encoding' },
  ['ftg'] = { ':set fenc=gbk<CR>:w<CR>', 'Convert buffer to GBK encoding' },

  ['str'] = {
    [[:%s/[\\]\@<!\(["]\)\(\(\(#{\)\@<![^"]\)\+\)\1/'\2'/gce<CR>]],
    'Convert double quotation string to single quotation',
  },
  ['sym'] = { [[:%s/[\\]\@<!\(['"]\)\([0-9A-Za-z_$]\+\)\1/:\2/gce<CR>]], 'Convert String to Symbol for Ruby' },
  ['hash'] = { [[:%s/\%(\w\|:\)\@1<!:\(\w\+\) *=> */\1: /gce<CR>]], "Convert hash to Ruby 1.9's JSON-like style" },
  ['url'] = { [[:%s/https\?:\/\/[^/]\+\/\@=//gce<CR>]], 'Convert url to a relative path' },
}

local secondary_vmappings = {
  ['str'] = {
    [[:s/[\\]\@<!\(["]\)\(\(\(#{\)\@<![^"]\)\+\)\1/'\2'/gce<CR>]],
    'Convert selected double quotation string to single quotation',
  },
  ['sym'] = { [[:s/[\\]\@<!\(['"]\)\([0-9A-Za-z_$]\+\)\1/:\2/gce<CR>]], 'Convert String to Symbol for Ruby' },
  ['hash'] = { [[:s/\%(\w\|:\)\@1<!:\(\w\+\) *=> */\1: /gce<CR>]], "Convert hash to Ruby 1.9's JSON-like style" },
  ['url'] = { [[:s/https\?:\/\/[^/]\+\/\@=//gce<CR>]], 'Convert url to a relative path' },
}

local raw_nmappings = {
  ['zf'] = { '<Plug>Chalk', 'Create fold at operator movement' },
  ['zF'] = { '<Plug>ChalkRange', 'Create fold for specified number of lines' },
  ['Zf'] = { '<Plug>SingleChalk', 'Create single (opening) fold marker at current level or specified count' },
  ['ZF'] = { '<Plug>SingleChalkUp', 'Create single (opening) fold marker at next level or specified count' },
  ['=z'] = { '<Plug>ChalkUp', 'Increment current fold level' },
  ['-z'] = { '<Plug>ChalkDown', 'Decrement current fold level' },
}

local raw_vmappings = {
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
      wk.register(primary_nmappings, { mode = 'n', prefix = ',' })
      wk.register(primary_vmappings, { mode = 'v', prefix = ',' })
      wk.register(secondary_nmappings, { mode = 'n', prefix = '\\' })
      wk.register(secondary_vmappings, { mode = 'v', prefix = '\\' })
      wk.register(raw_nmappings, { mode = 'n' })
      wk.register(raw_vmappings, { mode = 'v' })
    end,
  },
}

-- vim: set fdm=marker fdl=1 tw=120:
