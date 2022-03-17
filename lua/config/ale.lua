vim.g.ale_fixers = {
  lua = { 'stylua' },
  ruby = { 'rubocop' },
}
vim.g.ale_fix_on_save = 1
vim.g.ale_lua_stylua_options = '--search-parent-directories'
