-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del({ 'n', 'x' }, 'j')
vim.keymap.del({ 'n', 'x' }, 'k')

-- Navigate between windows and tabs  ................................... {{{1
--
-- CTRL-Tab for Next tab
vim.api.nvim_set_keymap('n', '<C-Tab>', 'gt', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-Tab>', '<Esc>gt', { noremap = true, silent = true })
vim.api.nvim_set_keymap('c', '<C-Tab>', '<C-\\><C-N>gt', { noremap = true, silent = true })

-- CTRL-SHIFT-Tab for Previous tab
vim.api.nvim_set_keymap('n', '<C-S-Tab>', 'gT', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-S-Tab>', '<Esc>gT', { noremap = true, silent = true })
vim.api.nvim_set_keymap('c', '<C-S-Tab>', '<C-\\><C-N>gT', { noremap = true, silent = true })

-- ⌘-[1-9]    Switch to specified buffer
for i = 1, 9 do
  vim.api.nvim_set_keymap(
    'n',
    '<D-' .. i .. '>',
    '<cmd>BufferLineGoToBuffer ' .. i .. '<CR>',
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    'i',
    '<D-' .. i .. '>',
    '<cmd>BufferLineGoToBuffer ' .. i .. '<CR>',
    { noremap = true, silent = true }
  )
end

-- Mapping for <D-0> to go to the last tab
vim.api.nvim_set_keymap('n', '<D-0>', ':tablast<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<D-0>', '<Esc>:tablast<CR>a', { noremap = true, silent = true })
-- ...................................................................... }}}1

-- Windows convention compatibility  .................................... {{{1
--
-- Cut with CTRL-X and SHIFT-Del in visual mode
vim.api.nvim_set_keymap('v', '<C-X>', '"+x', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-Del>', '"+x', { noremap = true, silent = true })

-- Copy with CTRL-C and CTRL-Insert in visual mode
vim.api.nvim_set_keymap('v', '<C-C>', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-Insert>', '"+y', { noremap = true, silent = true })

-- Paste with CTRL-V and SHIFT-Insert in normal and insert modes
vim.api.nvim_set_keymap('n', '<C-V>', '"+gP', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Insert>', '"+gP', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-V>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<S-Insert>', '<C-R>+', { noremap = true, silent = true })

-- Paste with CTRL-V and SHIFT-Insert in command mode
vim.api.nvim_set_keymap('c', '<C-V>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('c', '<S-Insert>', '<C-R>+', { noremap = true, silent = true })
--  ..................................................................... }}}1

-- Diff mode key mappings  .............................................. {{{1
--
-- <C-J/K>   Move cursor between diff chunks or windows
vim.keymap.set('n', '<C-J>', function()
  local keys = vim.wo.diff and ']c' or '<C-W>j'
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', false)
end, { noremap = true, desc = 'Move cursor between diff chunks or windows down' })

vim.keymap.set('n', '<C-K>', function()
  local keys = vim.wo.diff and '[c' or '<C-W>k'
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', false)
end, { noremap = true, desc = 'Move cursor between diff chunks or windows up' })
-- ...................................................................... }}}1

-- Close various informative/minor window with `q`  ..................... {{{1
--
vim.cmd([[
" Close left window (original file) in diff mode
nnoremap <expr> q &diff ? ':diffoff<CR><C-W>h:q<CR>' : 'q'
" Close Vim help window
autocmd FileType help nnoremap <buffer> q :q<CR>
" Close vim-fugitive window
autocmd FileType fugitive,git,gitcommit nnoremap <buffer> q :q<CR>
" Close netrw window
autocmd FileType netrw nnoremap <buffer> q :q<CR>
autocmd FileType netrw nnoremap <buffer> <C-L> <C-W>l
" Close QuickFix & Location window
autocmd FileType qf nnoremap <buffer> q :q<CR>
]])
-- ...................................................................... }}}1
