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

local function copy_diagnostic_to_clipboard()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
  local lines = {}
  for _, diag in ipairs(diagnostics) do
    table.insert(lines, diag.message)
  end
  local message = table.concat(lines, '\n')
  vim.fn.setreg('+', message)
  print('Diagnostic copied to clipboard')
end

_G.use_subword_motion = false
local function toggle_subword_motion()
  _G.use_subword_motion = not _G.use_subword_motion

  if _G.use_subword_motion then
    vim.keymap.set({ 'n', 'o', 'x' }, 'w', function() require('spider').motion('w') end)
    vim.keymap.set({ 'n', 'o', 'x' }, 'e', function() require('spider').motion('e') end)
    vim.keymap.set({ 'n', 'o', 'x' }, 'b', function() require('spider').motion('b') end)
    vim.keymap.set({ 'o', 'x' }, 'aw', function() require('various-textobjs').subword('outer') end)
    vim.keymap.set({ 'o', 'x' }, 'iw', function() require('various-textobjs').subword('inner') end)
  else
    vim.keymap.del({ 'n', 'o', 'x' }, 'w')
    vim.keymap.del({ 'n', 'o', 'x' }, 'e')
    vim.keymap.del({ 'n', 'o', 'x' }, 'b')
    vim.keymap.del({ 'o', 'x' }, 'aw')
    vim.keymap.del({ 'o', 'x' }, 'iw')
  end
  print('Subword motion and textobj is now ' .. (_G.use_subword_motion and 'enabled' or 'disabled'))
end
--  --------------------------------------------------------------------------------------------------------------- }}}2

local primary_nmappings = {
  mode = { 'n' },

  { ',c', group = 'Convenient Commands' },
  { ',ct', '<cmd>Telescope<CR>', desc = 'Telescope' },
  { ',cb', '<cmd>Telescope buffers<CR>', desc = 'Telescope Buffers' },
  { ',cf', '<cmd>Telescope find_files<CR>', desc = 'Find Files' },
  { ',cg', '<cmd>Telescope live_grep<CR>', desc = 'Telescope Live Grep' },
  { ',ch', '<cmd>Telescope help_tags<CR>', desc = 'Telescope Help Tags' },
  { ',ck', '<cmd>Telescope keymaps<CR>', desc = 'Telescope Keymaps' },
  { ',cl', '<cmd>Telescope colorscheme<CR>', desc = 'Telescope Color Scheme' },
  { ',cr', '<cmd>Telescope oldfiles<CR>', desc = 'Open Recent File' },

  { ',dc', copy_diagnostic_to_clipboard, desc = 'Copy Diagnostic to Clipboard' },

  { ',g', group = 'Git' },
  { ',gac', ':Git commit --amend --verbose<CR>', desc = 'Amend Commit Verbose' },
  { ',gb', ':Git blame<CR>', desc = 'Blame' },
  { ',gc', ':Git commit --verbose<CR>', desc = 'Commit Verbose' },
  { ',gd', ':Gvdiff<CR>', desc = 'Vertical Diff' },
  { ',ge', ':Gedit<CR>', desc = 'Edit' },
  { ',gf', ':Git difftool<CR>', desc = 'Diff Tool' },
  { ',gg', ':Ggrep<Space>', desc = 'Grep' },
  { ',gh', ':GH<CR>', desc = 'Open the link of current line on GitHub' },
  { ',gi', ':Gsplit! diff<CR><C-W>_', desc = 'Split Diff' },
  { ',gk', ':Gvdiff HEAD<CR><C-W>_', desc = 'Vertical Diff HEAD' },
  { ',gl', ':Gclog <CR>', desc = 'Log' },
  { ',gm', ':Git mergetool<CR>', desc = 'Merge Tool' },
  { ',gr', ':Gread<CR>', desc = 'Read' },
  { ',gs', ':Neogit<CR>', desc = 'Status' },
  { ',gw', ':Gwrite<CR>', desc = 'Write' },

  { ',li', '<cmd>LspInfo<CR>', desc = 'LSP Info' },
  { ',lr', '<cmd>LspRestart<CR>', desc = 'LSP Restart' },
  { ',lI', '<cmd>LspInstallInfo<CR>', desc = 'LSP Installer Info' },

  { ',nt', '<cmd>Neotree toggle<CR>', desc = 'Toggle Neo-tree' },
  { ',nf', '<cmd>Neotree filesystem reveal<CR>', desc = 'Neo-tree Reveal File' },

  { ',qt', '<cmd>tabclose<CR>', desc = 'Close Tab' },

  { ',rg', '<cmd>execute "Rg " . input("Rg search for pattern: ", "<C-R><C-W>")<CR>', desc = 'Rg Search' },

  { ',t', group = 'Toggles' },
  { ',ta', '<cmd>ALEToggle<CR>', desc = 'ALE Linting' },
  { ',tc', toggle_columns, desc = 'Columns' },
  { ',th', '<cmd>set hlsearch!<CR>', desc = 'Highlight Search' },
  { ',ti', '<cmd>IndentBlanklineToggle<CR>', desc = 'Indent Blankline' },
  { ',t_', toggle_subword_motion, desc = 'Toggle subword motion and textobject' },
  { ',tl', '<cmd>TagbarToggle<CR>', desc = 'Tagbar' },
  { ',to', '<cmd>Outline<CR>', desc = 'Outline' },
  { ',ts', '<cmd>set spell!<CR>', desc = 'Spell Check' },
  { ',tw', '<cmd>set wrap!<CR>', desc = 'Wrap' },

  { ',*', substitute_current_word, desc = 'Substitute current word under the cursor' },
  { ',cd', ':lcd %:p:h<CR>', desc = 'Change buffer directory to parent dir of current file' },
  { ',sr', ':SCCompileRun<CR>', desc = 'Compile and Run with SingleCompile' },
  { ',sc', ':SCCompile<CR>', desc = 'Compile with SingleCompile' },

  { ',cw', ':cwindow<CR>', desc = 'Open quickfix window' },
  { ',cq', ':cclose<CR>', desc = 'Close quickfix window' },

  { ',lw', ':lwindow<CR>', desc = 'Open location window' },
  { ',lq', ':lclose<CR>', desc = 'Close location window' },

  { ',,', ':cc<CR>', desc = 'Jump to current error in quickfix list' },
  { ',.', ':cnext<CR>', desc = 'Jump to next error in quickfix list' },
  { ',m', ':cNext<CR>', desc = 'Jump to prev error in quickfix list' },

  { ',<', ':ll<CR>', desc = 'Jump to current error in location list' },
  { ',>', ':lnext<CR>', desc = 'Jump to next error in location list' },
  { ',M', ':lNext<CR>', desc = 'Jump to prev error in location list' },

  { ',ff', ':set ff=unix<CR>:%!fromdos<CR>gg=G:%s/\\s\\+$//ge<CR>', desc = 'Format code' },
  { ',fc', ':set ff=unix<CR>:%!fromdos<CR>:%s/\\s\\+$//ge<CR>', desc = 'Clean code' },
}

local primary_vmappings = {}

local secondary_nmappings = {
  mode = { 'n' },

  { '\\ftu', ':set fenc=utf8<CR>:w<CR>', desc = 'Convert buffer to UTF-8 encoding' },
  { '\\ftg', ':set fenc=gbk<CR>:w<CR>', desc = 'Convert buffer to GBK encoding' },

  {
    '\\str',
    [[:%s/[\\]\@<!\(["]\)\(\(\(#{\)\@<![^"]\)\+\)\1/'\2'/gce<CR>]],
    desc = 'Convert double quotation string to single quotation',
  },
  {
    '\\sym',
    [[:%s/[\\]\@<!\(['"]\)\([0-9A-Za-z_$]\+\)\1/:\2/gce<CR>]],
    desc = 'Convert String to Symbol for Ruby',
  },
  {
    '\\hash',
    [[:%s/\%(\w\|:\)\@1<!:\(\w\+\) *=> */\1: /gce<CR>]],
    desc = "Convert hash to Ruby 1.9's JSON-like style",
  },
  { '\\url', [[:%s/https\?:\/\/[^/]\+\/\@=//gce<CR>]], desc = 'Convert url to a relative path' },
}

local secondary_vmappings = {
  mode = { 'v' },

  {
    '\\str',
    [[:s/[\\]\@<!\(["]\)\(\(\(#{\)\@<![^"]\)\+\)\1/'\2'/gce<CR>]],
    desc = 'Convert selected double quotation string to single quotation',
  },
  {
    '\\sym',
    [[:s/[\\]\@<!\(['"]\)\([0-9A-Za-z_$]\+\)\1/:\2/gce<CR>]],
    desc = 'Convert String to Symbol for Ruby',
  },
  {
    '\\hash',
    [[:s/\%(\w\|:\)\@1<!:\(\w\+\) *=> */\1: /gce<CR>]],
    desc = "Convert hash to Ruby 1.9's JSON-like style",
  },
  { '\\url', [[:s/https\?:\/\/[^/]\+\/\@=//gce<CR>]], desc = 'Convert url to a relative path' },
}

local raw_nmappings = {
  mode = { 'n' },

  { 'zf', '<Plug>Chalk', desc = 'Create fold at operator movement' },
  { 'zF', '<Plug>ChalkRange', desc = 'Create fold for specified number of lines' },
  { 'Zf', '<Plug>SingleChalk', desc = 'Create single (opening) fold marker at current level or specified count' },
  { 'ZF', '<Plug>SingleChalkUp', desc = 'Create single (opening) fold marker at next level or specified count' },
  { '=z', '<Plug>ChalkUp', desc = 'Increment current fold level' },
  { '-z', '<Plug>ChalkDown', desc = 'Decrement current fold level' },
}

local raw_vmappings = {
  mode = { 'v' },

  { 'zf', '<Plug>Chalk', desc = 'Create fold at visual selection' },
  { '=z', '<Plug>ChalkUp', desc = 'Increment levels in selection' },
  { '-z', '<Plug>ChalkDown', desc = 'Decrement levels in selection' },
}

return {
  -- WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing.
  {
    'folke/which-key.nvim',
    config = function()
      local wk = require('which-key')
      wk.add(primary_nmappings)
      wk.add(primary_vmappings)
      wk.add(secondary_nmappings)
      wk.add(secondary_vmappings)
      wk.add(raw_nmappings)
      wk.add(raw_vmappings)
    end,
  },
}

-- vim: set fdm=marker fdl=1 tw=120:
