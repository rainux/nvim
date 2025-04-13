-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Set foldmethod to manual to prevent performance issue for big files
local function set_fold_method()
  local file_size = vim.fn.getfsize(vim.fn.expand('%:p'))
  if file_size > 1000000 then -- Size in bytes, 1MB in this case
    vim.opt_local.foldmethod = 'manual'
  end
end

-- Autocommand setup
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufRead', 'BufWinEnter', 'VimEnter' }, {
  pattern = '*', -- Apply to all files
  callback = set_fold_method,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'json', 'xml' }, -- Add more heavy filetypes
  callback = function()
    vim.opt_local.foldmethod = 'manual'
    -- Additional settings
  end,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*.brg' },
  callback = function() vim.opt.syntax = 'rust' end,
})

-- Autocmd group for diff mode colorscheme switching
local group = vim.api.nvim_create_augroup('DiffColorScheme', { clear = true })
-- Use 'onedarker' colorscheme in diff mode for much better diff highlighting
-- vim.api.nvim_create_autocmd('OptionSet', {
-- pattern = 'diff',
-- callback = function()
-- if vim.opt.diff:get() then
-- vim.cmd('colorscheme onedarker')
-- else
-- vim.cmd('colorscheme tokyonight')
-- end
-- end,
-- group = group,
-- })
