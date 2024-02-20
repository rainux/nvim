-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Override LazyVim default keymaps
vim.keymap.del({ 'n', 'x' }, 'j')
vim.keymap.del({ 'n', 'x' }, 'k')

-- Navigate in content  ------------------------------------------------------------------------------------------- {{{1
--
-- Up & Down   Navigate display line upward & downward
vim.keymap.set('n', '<Up>', 'gk', { silent = true })
vim.keymap.set('n', '<Down>', 'gj', { silent = true })
vim.keymap.set('i', '<Up>', '<Esc><Up>a', { silent = true })
vim.keymap.set('i', '<Down>', '<Esc><Down>a', { silent = true })

-- Emacs-style editing on the command-line
vim.cmd([[
" start of line
cnoremap <C-A>         <Home>
" back one character
cnoremap <C-B>         <Left>
" delete character under cursor
cnoremap <C-D>         <Del>
" end of line
cnoremap <C-E>         <End>
" forward one character
cnoremap <C-F>         <Right>
" recall newer command-line
cnoremap <C-N>         <Down>
" recall previous (older) command-line
cnoremap <C-P>         <Up>
" back one word
cnoremap <Esc><C-B>    <S-Left>
" forward one word
cnoremap <Esc><C-F>    <S-Right>
]])
--  --------------------------------------------------------------------------------------------------------------- }}}1

-- Navigate between windows and tabs  ----------------------------------------------------------------------------- {{{1
--
-- CTRL-Tab for Next tab
vim.keymap.set('n', '<C-Tab>', 'gt', { silent = true })
vim.keymap.set('i', '<C-Tab>', '<Esc>gt', { silent = true })
vim.keymap.set('c', '<C-Tab>', '<C-\\><C-N>gt', { silent = true })

-- CTRL-SHIFT-Tab for Previous tab
vim.keymap.set('n', '<C-S-Tab>', 'gT', { silent = true })
vim.keymap.set('i', '<C-S-Tab>', '<Esc>gT', { silent = true })
vim.keymap.set('c', '<C-S-Tab>', '<C-\\><C-N>gT', { silent = true })

-- ⌘-[1-9]  Switch to specified buffer
for i = 1, 9 do
  vim.keymap.set('n', '<D-' .. i .. '>', '<cmd>BufferLineGoToBuffer ' .. i .. '<CR>', { silent = true })
  vim.keymap.set('i', '<D-' .. i .. '>', '<cmd>BufferLineGoToBuffer ' .. i .. '<CR>', { silent = true })
end

-- ⌘-0      Go to the last tab
vim.keymap.set('n', '<D-0>', ':tablast<CR>', { silent = true })
vim.keymap.set('i', '<D-0>', '<Esc>:tablast<CR>a', { silent = true })
--  --------------------------------------------------------------------------------------------------------------- }}}1

-- Windows convention compatibility  ------------------------------------------------------------------------------ {{{1
--
-- Cut with CTRL-X and SHIFT-Del in visual mode
vim.keymap.set('v', '<C-X>', '"+x', { silent = true })
vim.keymap.set('v', '<S-Del>', '"+x', { silent = true })

-- Copy with CTRL-C and CTRL-Insert in visual mode
vim.keymap.set('v', '<C-C>', '"+y', { silent = true })
vim.keymap.set('v', '<C-Insert>', '"+y', { silent = true })

-- Paste with CTRL-V and SHIFT-Insert in normal and insert modes
vim.keymap.set('n', '<C-V>', '"+gP', { silent = true })
vim.keymap.set('n', '<S-Insert>', '"+gP', { silent = true })
vim.keymap.set('i', '<C-V>', '<C-R>+', { silent = true })
vim.keymap.set('i', '<S-Insert>', '<C-R>+', { silent = true })

-- Paste with CTRL-V and SHIFT-Insert in command mode
vim.keymap.set('c', '<C-V>', '<C-R>+', { silent = true })
vim.keymap.set('c', '<S-Insert>', '<C-R>+', { silent = true })
--  --------------------------------------------------------------------------------------------------------------- }}}1

-- Diff mode key mappings  ---------------------------------------------------------------------------------------- {{{1
--
-- <C-J/K>   Move cursor between diff chunks or windows
vim.keymap.set('n', '<C-J>', function()
  local keys = vim.wo.diff and ']c' or '<C-W>j'
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', false)
end, { silent = true })

vim.keymap.set('n', '<C-K>', function()
  local keys = vim.wo.diff and '[c' or '<C-W>k'
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', false)
end, { silent = true })
--  --------------------------------------------------------------------------------------------------------------- }}}1

-- Close various informative/minor window with `q`  --------------------------------------------------------------- {{{1
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
--  --------------------------------------------------------------------------------------------------------------- }}}1

-- vim: set fdm=marker fdl=1 textwidth=120:
