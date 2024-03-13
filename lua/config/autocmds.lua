-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- TODO: This only required due to VimR's bug related to filetype detection
vim.cmd([[
  augroup GuessIndent
    autocmd BufEnter * :GuessIndent
  augroup end
]])

-- Autocmd group for diff mode colorscheme switching
local group = vim.api.nvim_create_augroup('DiffColorScheme', { clear = true })

-- Use 'onedarker' colorscheme in diff mode for much better diff highlighting
vim.api.nvim_create_autocmd('OptionSet', {
  pattern = 'diff',
  callback = function()
    if vim.opt.diff:get() then
      vim.cmd('colorscheme onedarker')
    else
      vim.cmd('colorscheme tokyonight')
    end
  end,
  group = group,
})
